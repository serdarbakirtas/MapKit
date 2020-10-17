//
//  ViewModelsUnitTest.swift
//  Free-NowTests
//
//  Created by Hasan on 17.10.20.
//

@testable import Free_Now
import XCTest

class ViewModelsUnitTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testGettingVehicleListViewModelForStateColor() {
        let coordinate = Coordinate(latitude: 53.694865, longitude: 9.757589)
        let poiList = PoiList(id: 1, coordinate: coordinate, state: .ACTIVE, type: .TAXI, heading: 0.0)
        let vehicleListViewModel = VehicleListViewModel(from: poiList)
        
        XCTAssertTrue(vehicleListViewModel.stateColor == .green)
    }
}
