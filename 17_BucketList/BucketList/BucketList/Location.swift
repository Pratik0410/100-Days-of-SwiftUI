//
//  Location.swift
//  BucketList
//
//  Created by Prathamesh Sonawane on 04/07/24.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    #if DEBUG
    static let example = Location(id: UUID(), name: "India", description: "Democratic country", latitude: 21.0000, longitude: 78.0000)
    #endif
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
