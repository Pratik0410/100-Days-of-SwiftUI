//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Prathamesh Sonawane on 18/07/24.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
