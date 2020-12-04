//
//  VehiclePin.swift
//
//  Created by Hasan on 16.10.20.
//

import MapKit

class VehiclePin: NSObject, MKAnnotation {
    let title: String?
    let id: Int?
    let coordinate: CLLocationCoordinate2D
  
    init(title: String?, id: Int?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.id = id
        self.coordinate = coordinate
    }
}
