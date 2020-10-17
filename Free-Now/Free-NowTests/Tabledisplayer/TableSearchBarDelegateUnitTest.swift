//
//  TableSearchBarDelegateUnitTest.swift
//  Free-NowTests
//
//  Created by Hasan on 17.10.20.
//

@testable import Free_Now
import XCTest

class TableSearchBarDelegateUnitTest: XCTestCase {
    
    let tableDisplayer = PaginatedSearchableTableViewMock()
    var searchDelegateHandler: TableSearchBarDelegateHandler!
    
    override func setUp() {
        super.setUp()
        
        tableDisplayer.setupPaginatedTable()
        searchDelegateHandler = TableSearchBarDelegateHandler(searchableTable: tableDisplayer)
    }
    
    func testBeginningTextEditingShowsCancelButtonInSearchBar() {
        searchDelegateHandler.searchBarTextDidBeginEditing(tableDisplayer.searchBar)
        
        XCTAssert(tableDisplayer.searchBar.showsCancelButton)
    }
    
    func testEndingTextEditingHidesCancelButtonInSearchBar() {
        tableDisplayer.searchBar.setShowsCancelButton(true, animated: false)
        
        searchDelegateHandler.searchBarTextDidEndEditing(tableDisplayer.searchBar)
        
        XCTAssertFalse(tableDisplayer.searchBar.showsCancelButton)
    }
    
    func testClickingSearchButtonEndsEditing() {
        let window = UIWindow()
        window.addSubview(tableDisplayer.searchBar)
        tableDisplayer.searchBar.becomeFirstResponder()
        XCTAssert(tableDisplayer.searchBar.isFirstResponder)

        searchDelegateHandler.searchBarSearchButtonClicked(tableDisplayer.searchBar)
        
        // calling endEditing for searchbar makes it lose its first responder status
        XCTAssertFalse(tableDisplayer.searchBar.isFirstResponder)
    }
    
    func testClickingCancelButtonResetsSearchBar() {
        tableDisplayer.searchBar.text = "search"
        
        searchDelegateHandler.searchBarCancelButtonClicked(tableDisplayer.searchBar)
        
        XCTAssertEqual(tableDisplayer.searchBar.text, "")
    }
    
    func testClickingCancelButtonReStartsSearchEmptySearchString() {
        tableDisplayer.searchBar.text = "search"
        
        searchDelegateHandler.searchBarCancelButtonClicked(tableDisplayer.searchBar)
        
        XCTAssertEqual(tableDisplayer.loadedPages, [1])
        XCTAssertEqual(tableDisplayer.loadedSearchStrings, [""])
    }
    
    func testChangingTextStartsSearchAfterQuickDelay() {
        tableDisplayer.searchBar.text = "search"
        searchDelegateHandler.searchBar(tableDisplayer.searchBar, textDidChange: "search")
        let exp = expectation(description: "wait for search")
        let waited = XCTWaiter.wait(for: [exp], timeout: 0.3)
        guard waited == .timedOut else {
            XCTFail("Did not wait for search")
            return
        }
        
        XCTAssertEqual(tableDisplayer.loadedPages, [1])
        XCTAssertEqual(tableDisplayer.loadedSearchStrings, ["search"])
    }
}
