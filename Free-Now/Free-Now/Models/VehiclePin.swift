//
//  VehiclePin.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import MapKit

class VehiclePin: NSObject, MKAnnotation {
    let id: Int?
    let coordinate: CLLocationCoordinate2D
  
    
    init(id: Int?, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.coordinate = coordinate
    }
}
