//
//  Prospect.swift
//  HotProspects
//
//  Created by Prathamesh Sonawane on 21/07/24.
//

import SwiftData
import SwiftUI

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var lastContactedAt = Date()
    
    init(name: String, emailAddress: String, isContacted: Bool) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}
