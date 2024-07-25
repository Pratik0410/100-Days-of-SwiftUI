//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Prathamesh Sonawane on 21/07/24.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortOrder {
        case byName, byMostRecent
    }
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospectsByName: [Prospect]
    @Query(sort: \Prospect.lastContactedAt, order: .reverse) var prospectsByMostRecent: [Prospect]
    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    @State private var everyoneImage: String = "person.crop.circle.badge.xmark"
    @State private var everyoneImageColor = Color.blue
    @State private var editProspectSheet = false
    @State private var sortOrder = SortOrder.byName
    let filterType: FilterType
    
    var title: String {
        switch filterType {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }
    
    var body: some View {
        NavigationStack {
            
            List(sortOrder == .byName ? prospectsByName : prospectsByMostRecent, selection: $selectedProspects) { prospect in
                NavigationLink(destination: EditProspectView(prospect: prospect)) {
                    HStack(alignment: .center, spacing: 20) {
                        if title == "Everyone" {
                            Image(systemName: everyoneImage)
                                .font(.title2)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button("Edit", systemImage: "pencil") {
                            editProspectSheet.toggle()
                        }
                        .tint(.purple)
                    }
                    .swipeActions {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            modelContext.delete(prospect)
                        }
                        
                        if prospect.isContacted {
                            Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                                prospect.isContacted.toggle()
                            }
                            .tint(.blue)
                        } else {
                            Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                                prospect.isContacted.toggle()
                            }
                            .tint(.green)
                            
                            Button("Remind me", systemImage: "bell") {
                                addNotification(for: prospect)
                            }
                            .tint(.orange)
                        }
                    }
                    .onChange(of: prospect.isContacted, { oldValue, newValue in
                        if !prospect.isContacted {
                            everyoneImage = "person.crop.circle.badge.xmark"
                        } else {
                            everyoneImage = "person.crop.circle.fill.badge.checkmark"
                        }
                    })
                    .tag(prospect)
                    .sheet(isPresented: $editProspectSheet) {
                        EditProspectView(prospect: prospect)
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("By name")
                                .tag(SortDescriptor(\Prospect.name))
                            
                            Text("By most recent")
                                .tag(SortDescriptor(\Prospect.lastContactedAt, order: .reverse))
                        }
                    }
                }
                
                if selectedProspects.isEmpty == false {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete selected", action: delete)
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Name\nemailAddress@email.com", completion: handleScan)
            }
        }
    }
    
    init(filterType: FilterType) {
        self.filterType = filterType
        
        if filterType != .none {
            let showContactedOnly = filterType == .contacted
            
            _prospectsByName = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
            
            _prospectsByMostRecent = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.lastContactedAt, order: .reverse)])
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            
            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
//            var dateComponents = DateComponents()
//            dateComponents.hour = 11
            
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filterType: .none)
        .modelContainer(for: Prospect.self)
}
