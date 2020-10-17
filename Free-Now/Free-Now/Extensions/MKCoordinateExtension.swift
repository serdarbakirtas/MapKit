//
//  MKCoordinateExtension.swift
//  Free-Now
//
//  Created by Hasan on 17.10.20.
//

import MapKit

extension MKMapView {
    
    func topLeftCoordinate(topPadding: CGFloat = 0) -> Coordinate {
        let coordinate = convert(CGPoint(x: 0, y: topPadding), toCoordinateFrom: self)
        return Coordinate(coordinate: coordinate)
    }
    
    func bottomRightCoordinate(bottomPadding: CGFloat = 0) -> Coordinate {
        let coordinate = convert(CGPoint(x: frame.width, y: frame.height - bottomPadding), toCoordinateFrom: self)
        return Coordinate(coordinate: coordinate)
    }
}
