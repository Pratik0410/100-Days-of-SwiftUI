//
//  ContentView.swift
//  SwiftDataChallenge
//
//  Created by Prathamesh Sonawane on 20/02/24.
//

import Network
import SwiftUI

struct ContentView: View {
    @State var user = [User]()
    
    var body: some View {
        NavigationStack {
            List(user, id: \.id) { item in
                LazyVStack {
                    let isActive = item.isActive
                    NavigationLink(destination: UserDetailView(user: item)) {
                        Text("\(item.name)\n\(isActive ? "Active" : "Inactive")")
                    }
                }
                
            }
            .navigationTitle("Challenge Day")
        }
        .task {
            await userDecoder()
        }
    }
    
    func userDecoder() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedUsers = try decoder.decode([User].self, from: data) // Directly decoding to [User]
            DispatchQueue.main.async {
                self.user = decodedUsers
            }
        } catch {
            print("Decoding failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
