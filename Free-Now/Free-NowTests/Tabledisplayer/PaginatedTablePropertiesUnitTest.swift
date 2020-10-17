//
//  PaginatedTablePropertiesUnitTest.swift
//  Free-NowTests
//
//  Created by Hasan on 17.10.20.
//

import XCTest

import Foundation
@testable import Free_Now
import XCTest

class PaginatedTablePropertiesUnitTest: XCTestCase {
    
    // MARK: PaginatedTableProperties
    let tableProperties = PaginatedTableProperties()
    
    func testResettingPages() {
        tableProperties.pageBySection = [0: 1, 1: 3]
        
        tableProperties.resetPages()
        
        XCTAssertEqual(tableProperties.pageBySection, [:])
    }
    
    func testSetRefreshing() {
        tableProperties.setRefreshing(isRefreshing: true)
        
        XCTAssert(tableProperties.isRefreshing)
    }
    
    func testSetLoading() {
        tableProperties.setLoading(section: 1, isLoading: true)
        
        XCTAssert(tableProperties.isLoadingBySection[1]!)
    }
    
    func testSettingCellHeight() {
        tableProperties.setCellHeight(at: IndexPath(row: 1, section: 1), height: 50)
        
        XCTAssertEqual(tableProperties.heightAtIndex[IndexPath(row: 1, section: 1)], 50)
    }
    
    func testGettingCellHeight() {
        tableProperties.heightAtIndex[IndexPath(row: 1, section: 1)] = 50
        
        XCTAssertEqual(tableProperties.getCellHeight(at: IndexPath(row: 1, section: 1)), 50)
    }
    
    func testGettingPage() {
        tableProperties.pageBySection[1] = 2
        
        XCTAssertEqual(tableProperties.getPage(section: 1), 2)
    }
    
    func testSettingAllSectionsLoading() {
        tableProperties.setAllSectionsLoading(numberOfSections: 3, isLoading: true)
        
        XCTAssert(tableProperties.isLoadingBySection[0]!)
        XCTAssert(tableProperties.isLoadingBySection[1]!)
        XCTAssert(tableProperties.isLoadingBySection[2]!)
    }
    
    func testLoadingLastSectionReturnsTrueForWillAllSectionsBeLoaded() {
        tableProperties.isLoadingBySection[0] = false
        tableProperties.isLoadingBySection[1] = false
        tableProperties.isLoadingBySection[2] = true
        
        XCTAssert(tableProperties.willAllSectionsBeLoaded(section: 2, numberOfSections: 3))
    }
    
    func testLoadingMultipleSectionsReturnsFalseWillAllSectionsBeLoaded() {
        tableProperties.isLoadingBySection[0] = false
        tableProperties.isLoadingBySection[1] = true
        tableProperties.isLoadingBySection[2] = true
        
        XCTAssertFalse(tableProperties.willAllSectionsBeLoaded(section: 1, numberOfSections: 3))
    }
    
    // There are 3 conditions for table to load next page while table is preparing to show a row:
    // 1. The section that is shown is not already loading next page
    // 2. The row number plus the threshold is bigger than the last loaded item no
    // (so say there total 20 item and threshold is 5, then showing 14th item will not load next page but 16th will)
    // 3. The table is refreshing or not all items possible in list are loaded
    // (since refreshing removes everything and loads list again, it doesn't matter if we loaded everything or not)
    func testShouldLoadNextPage() {
        tableProperties.isLoadingBySection[0] = false
        tableProperties.isRefreshing = false
        tableProperties.loadedItemsCountBySection[0] = 10
        tableProperties.totalItemsCountBySection[0] = 25
        
        XCTAssert(tableProperties.shouldLoadNextPage(index: IndexPath(row: 5, section: 0),
                                                     presentedItemsCount: 10))
    }
    
    func testAlreadyLoadingSectionPreventsLoadingNextPage() {
        tableProperties.isLoadingBySection[0] = true
        tableProperties.isRefreshing = false
        tableProperties.loadedItemsCountBySection[0] = 10
        tableProperties.totalItemsCountBySection[0] = 25
        
        XCTAssertFalse(tableProperties.shouldLoadNextPage(index: IndexPath(row: 5, section: 0),
                                                          presentedItemsCount: 10))
    }
    
    func testRefreshingTableLoadsNextPageIndependentOfLoadedItemsCount() {
        tableProperties.isLoadingBySection[0] = false
        tableProperties.isRefreshing = true
        tableProperties.loadedItemsCountBySection[0] = 25
        tableProperties.totalItemsCountBySection[0] = 25
        
        XCTAssert(tableProperties.shouldLoadNextPage(index: IndexPath(row: 25, section: 0),
                                                     presentedItemsCount: 25))
    }
    
    func testAlreadyHavingLoadedAllItemsPreventsLoadingNextPage() {
        tableProperties.isLoadingBySection[0] = false
        tableProperties.isRefreshing = false
        tableProperties.loadedItemsCountBySection[0] = 25
        tableProperties.totalItemsCountBySection[0] = 25
        
        XCTAssertFalse(tableProperties.shouldLoadNextPage(index: IndexPath(row: 25, section: 0),
                                                          presentedItemsCount: 25))
    }
    
    func testShowingEarlierRowsDoesNotLoadNextPage() {
        tableProperties.isLoadingBySection[0] = false
        tableProperties.isRefreshing = false
        tableProperties.loadedItemsCountBySection[0] = 20
        tableProperties.totalItemsCountBySection[0] = 25
        
        XCTAssertFalse(tableProperties.shouldLoadNextPage(index: IndexPath(row: 5, section: 0),
                                                          presentedItemsCount: 20))
    }
}
