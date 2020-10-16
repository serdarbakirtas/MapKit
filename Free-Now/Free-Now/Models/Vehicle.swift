//
//  Vehicle.swift
//  Free-Now
//
//  Created by Hasan on 15.10.20.
//

import MapKit

enum StateType: String, Decodable {
    case ACTIVE = "ACTIVE"
    case PASSIVE = "PASSIVE"
}

enum VehicleType: String, Decodable {
    case TAXI = "TAXI"
    case BUS = "BUS"
}

struct Vehicle: Decodable {
    
    var poiList: [PoiList]?
}

struct PoiList: Decodable {
    
    var id: Int?
    var coordinate: Coordinate?
    var state: StateType
    var type: VehicleType
    var heading: Double?
    
}

struct Coordinate: Codable {
    
    var latitude: Double
    var longitude: Double
    
    func locationCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
