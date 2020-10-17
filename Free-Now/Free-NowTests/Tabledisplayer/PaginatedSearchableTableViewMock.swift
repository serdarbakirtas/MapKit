//
//  PaginatedSearchableTableViewMock.swift
//  Free-NowTests
//
//  Created by Hasan on 17.10.20.
//

@testable import Free_Now
import XCTest

class PaginatedSearchableTableViewMock: UIViewController, PaginatedTableDisplayer, SearchableTableDisplayer,
    UITableViewDataSource {
    
    let properties = PaginatedTableProperties()
    let table = UITableView()
    let searchView = TableSearchBar()
    let indicator = UIActivityIndicatorView()
    var searchDelegate: TableSearchBarDelegateHandler!
    
    var numberOfRowsBySection: [Int: Int] = [0: 0]
    var numberOfSections = 1
    
    var loadedPages: [Int] = []
    var loadedSections: [Int] = []
    var loadedSearchStrings: [String] = []
    
    var isAddSearchBarToTableCalled = false
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        table.dataSource = self
    }
    
    var tableView: UITableView {
        table
    }
    
    var activityIndicator: UIActivityIndicatorView {
        indicator
    }
    
    var tableDescription: TableDescription {
        TableDescription(singleDescription: "items")
    }
    
    var tableProperties: PaginatedTableProperties {
        properties
    }
    
    var searchBar: UISearchBar {
        return searchView
    }
    
    var searchBarDelegateHandler: TableSearchBarDelegateHandler {
        searchDelegate
    }
    
    func addSearchBarToTable() {
        isAddSearchBarToTableCalled = true
        searchDelegate = TableSearchBarDelegateHandler(searchableTable: self)
    }
    
    func loadItems(page: Int, section: Int, searchString: String) {
        loadedPages.append(page)
        loadedSections.append(section)
        loadedSearchStrings.append(searchString)
    }
    
    func onRefresh() {}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsBySection[section]!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
