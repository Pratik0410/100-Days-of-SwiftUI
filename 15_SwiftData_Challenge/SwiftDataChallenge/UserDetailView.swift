//
//  UserDetailView.swift
//  SwiftDataChallenge
//
//  Created by Prathamesh Sonawane on 20/02/24.
//

import SwiftUI

struct UserDetailView: View {
    @State var user: User
    
    let itemDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    Text("Age :")
                        .bold()
                        .font(.title)
                    Text("\(user.age)")
                    Text("Company :")
                        .bold()
                        .font(.title)
                    Text("\(user.company)")
                    Text("Email :")
                        .bold()
                        .font(.title)
                    Text("\(user.email)")
                    Text("Address :")
                        .bold()
                        .font(.title)
                    Text("\(user.address)")
                    Text("About :")
                        .bold()
                        .font(.title)
                    Text("\(user.about)")
                    Text("Registered :")
                        .bold()
                        .font(.title)
                    Text("\(user.registered, formatter: itemDateFormatter)")
                    Text("Tags : ")
                        .bold()
                        .font(.title)
                    ForEach(user.tags, id: \.self) {
                        item in
                        Text(item)
                    }
                    Text("Friends : ")
                        .bold()
                        .font(.title)
                    ForEach(user.friends, id: \.id) {
                        item in
                        Text(item.name)
                    }
                }
                .padding()
                .navigationTitle(user.name)
            }
        }
    }
}

//#Preview {
//    UserDetailView()
//}
