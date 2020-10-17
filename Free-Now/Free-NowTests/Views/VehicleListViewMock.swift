//
//  VehicleListViewMock.swift
//  Free-NowTests
//
//  Created by Hasan on 17.10.20.
//

import Foundation
@testable import Free_Now
import XCTest

class VehicleListViewMock: BaseViewMock, VehicleListView, PaginatedTableDisplayerMock, SearchableTableDisplayerMock {

    var reloadTableViewExp = XCTestCase().expectation(description: "Reload Table View")
    
    var isRefreshTableCalled = false
    
    func reloadPaginatedTable() {
        reloadTableViewExp.fulfill()
    }
    
    func refreshTable() {
        isRefreshTableCalled = true
    }
    
    func onRefresh() {}
}
