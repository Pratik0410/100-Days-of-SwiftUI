//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Prathamesh Sonawane on 15/02/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
