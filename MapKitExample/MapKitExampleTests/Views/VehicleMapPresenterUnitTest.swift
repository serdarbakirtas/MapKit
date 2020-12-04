//
//  VehicleMapPresenterUnitTest.swift
//
//  Created by Hasan on 17.10.20.
//

@testable import MapKitExample
import XCTest
import MapKit

class VehicleMapPresenterUnitTest: XCTestCase {

    var presenter: VehicleMapPresenter<VehicleMapViewMock>!
    let viewMock = VehicleMapViewMock()
    let mapKitExampleNowAPIMock = MapKitExampleAPIMock()
    
    var vehicle = Vehicle()
    
    override func setUp() {
        super.setUp()
        
        presenter = VehicleMapPresenter(view: viewMock, apiInstance: mapKitExampleNowAPIMock)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoadingVehicle() {
        presenter.loadVehicle(p2latitude: 53.394655, p1longitude: 9.757589,
                              p1latitude: 53.694865, p2longitude: 10.099891)
        
        XCTAssert(mapKitExampleNowAPIMock.isLocationCalled)
    }
    
    func testLoadingVehicleAddsAnnotation() {
        presenter.loadVehicle(p2latitude: 53.394655, p1longitude: 9.757589,
                              p1latitude: 53.694865, p2longitude: 10.099891)
        
        wait(for: [viewMock.addAnnotationExpectation], timeout: 1)
        
        XCTAssert(mapKitExampleNowAPIMock.isLocationCalled)
        XCTAssert(viewMock.isAddAnnotationsCalled)
        XCTAssertEqual(presenter.annotations.count, 1)
    }
    
    func testRemoveingAnnotation() {
        presenter.removeAnnotations()
        
        wait(for: [viewMock.removeAnnotationExpectation], timeout: 1)
        
        XCTAssert(viewMock.isRemoveAnnotationsCalled)
        XCTAssertEqual(presenter.annotations.count, 0)
    }
    
    func testCallingInitalLocation() {
        presenter.initialLocation()
        
        XCTAssert(viewMock.isInitialLocationCalled)
    }
    
    func testCoordinat() {
        presenter.coordinateRegion()
        
        XCTAssert(viewMock.isCoordinantRegionCalled)
        XCTAssertEqual(viewMock.regionLatitude, 53.394655)
        XCTAssertEqual(viewMock.regionLongitude, 10.099891)

    }
}
