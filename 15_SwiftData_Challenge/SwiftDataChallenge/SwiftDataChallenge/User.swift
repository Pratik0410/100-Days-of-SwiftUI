//
//  User.swift
//  SwiftDataChallenge
//
//  Created by Prathamesh Sonawane on 20/02/24.
//

import Foundation

class User : Codable, Identifiable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friends]
}
