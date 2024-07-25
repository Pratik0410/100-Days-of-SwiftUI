//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Prathamesh Sonawane on 24/07/24.
//

import SwiftData
import SwiftUI

struct EditProspectView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var prospect: Prospect
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name: ", text: $prospect.name)
                    .textContentType(.name)
                    .font(.title3)
                
                TextField("Email: ", text: $prospect.emailAddress)
                    .textContentType(.emailAddress)
            }
            .navigationTitle("Edit")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let prospect = Prospect(name: "Hello", emailAddress: "email@email.com", isContacted: false)
        return EditProspectView(prospect: prospect)
            .modelContainer(for: Prospect.self)
    } catch {
        return Text("Failed to crete container: \(error.localizedDescription)")
    }
}
