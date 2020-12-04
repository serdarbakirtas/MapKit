//
//  MapKitExampleAPIMock.swift
//
//  Created by Hasan on 17.10.20.
//

import Foundation
@testable import MapKitExample
import RxSwift
import XCTest

class MapKitExampleAPIMock: MapKitExampleAPI {
    
    var isLocationCalled = false
    
    init() {}
    
    private func createVehicleListObject() -> Vehicle {
        var vehicle = Vehicle()
        vehicle.poiList = [createPoiListObject()]
        return vehicle
    }
    
    private func createPoiListObject() -> PoiList {
        let coordinate = Coordinate(latitude: 53.694865, longitude: 9.757589)
        let poiList = PoiList(id: 1, coordinate: coordinate, state: .ACTIVE, type: .TAXI, heading: 0.0)
        return poiList
    }
    
    func getVehicleList() -> Single<Vehicle> {
        let vehicle = createVehicleListObject()
        return Single.just(vehicle)
    }
    
    func getVehicleListWithLocation(p2latitude: Double, p1longitude: Double,
                                    p1latitude: Double, p2longitude: Double) -> Single<Vehicle> {
        isLocationCalled = true
        let vehicle = createVehicleListObject()
        return Single.just(vehicle)
    }
}
