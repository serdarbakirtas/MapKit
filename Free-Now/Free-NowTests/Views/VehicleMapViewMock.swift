//
//  VehicleMapViewMock.swift
//  Free-NowTests
//
//  Created by Hasan on 17.10.20.
//

import XCTest

import Foundation
@testable import Free_Now
import MapKit
import XCTest

class VehicleMapViewMock: BaseViewMock, VehicleMapView {
    
    var addAnnotationExpectation = XCTestCase().expectation(description: "Add Annotation")
    var removeAnnotationExpectation = XCTestCase().expectation(description: "Remove Annotation")
    
    var isRemoveAnnotationsCalled = false
    var isAddAnnotationsCalled = false
    var isInitialLocationCalled = false
    var isCoordinantRegionCalled = false
    
    var initialLocation = CLLocation(latitude: 53.694865, longitude: 9.757589)
    var annotation = [MKAnnotation]()
    
    var regionLatitude: Double = 0.0
    var regionLongitude: Double = 0.0
    
    
    
    func setCoordinateRegion(coordinateRegion: MKCoordinateRegion) {
        regionLatitude = coordinateRegion.center.latitude
        regionLongitude = coordinateRegion.center.longitude
        isCoordinantRegionCalled = true
    }
    
    func initialLocation(initialLocation: CLLocation) {
        self.initialLocation = initialLocation
        isInitialLocationCalled = true
    }
    
    func addAnnotations(annotation: [MKAnnotation]) {
        self.annotation = annotation
        isAddAnnotationsCalled = true
        addAnnotationExpectation.fulfill()
    }
    
    func removeAnnotations() {
        isRemoveAnnotationsCalled = true
        removeAnnotationExpectation.fulfill()
    }
}
