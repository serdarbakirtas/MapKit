//
//  VehicleListViewMock.swift
//
//  Created by Hasan on 17.10.20.
//

import Foundation
@testable import MapKitExample
import XCTest

class VehicleListViewMock: BaseViewMock, VehicleListView {

    var reloadTableViewExp = XCTestCase().expectation(description: "Reload Table View")
    
    var isRefreshTableCalled = false
    
    func reloadTable() {
        reloadTableViewExp.fulfill()
        isRefreshTableCalled = true
    }
    
    func onRefresh() {}
}
