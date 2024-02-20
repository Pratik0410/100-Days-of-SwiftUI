//
//  Job.swift
//  SwiftDataProject
//
//  Created by Prathamesh Sonawane on 16/02/24.
//

import Foundation
import SwiftData

@Model
class Job {
    var name: String
    var priority: Int
    var owner: User?
    
    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}
