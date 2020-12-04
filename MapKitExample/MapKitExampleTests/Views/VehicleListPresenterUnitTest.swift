//
//  VehicleListPresenterUnitTest.swift
//
//  Created by Hasan on 17.10.20.
//

@testable import MapKitExample
import XCTest

class VehicleListPresenterUnitTest: XCTestCase {

    var presenter: VehicleListPresenter<VehicleListViewMock>!
    let viewMock = VehicleListViewMock()
    let mapKitExampleNowAPIMock = MapKitExampleAPIMock()
    
    let poiList1 = PoiList(id: 1,
                           coordinate: Coordinate(latitude: 53.694865, longitude: 9.757589),
                           state: .ACTIVE, type: .TAXI, heading: 0.0)
    let poiList2 = PoiList(id: 2,
                           coordinate: Coordinate(latitude: 53.694865, longitude: 9.757589),
                           state: .ACTIVE, type: .TAXI, heading: 0.0)
    
    override func setUp() {
        super.setUp()
        
        presenter = VehicleListPresenter(view: viewMock, apiInstance: mapKitExampleNowAPIMock)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGettingTableDescription() {
        XCTAssertEqual(presenter.getTableDescription().table, "Vehicle")
    }
    
    func testGettingVehicleListCount() {
        presenter.items.append(poiList1)
        presenter.items.append(poiList2)
        
        XCTAssertEqual(presenter.getVehicleListCount(), 2)
    }
    
    func testGettingVehicleListViewModel() {
        presenter.items.append(poiList1)
        
        let viewModel = presenter.getVehicleListViewModel(index: 0)
        
        XCTAssertEqual(viewModel.type, poiList1.type.rawValue)
    }
    
    func testLoadingVehicleListAddsVehicleList() {
        presenter.loadVehicle()
        wait(for: [viewMock.reloadTableViewExp], timeout: 1)
        
        XCTAssertEqual(presenter.items.count, 1)
    }
}
