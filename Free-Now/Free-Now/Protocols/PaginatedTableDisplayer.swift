//
//  PaginatedTableDisplayer.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import Foundation
import UIKit

@objc protocol RefreshableTable {
    @objc func onRefresh()
}

protocol PaginatedTableDisplayer: StandardTableDisplayer, RefreshableTable {
    var tableProperties: PaginatedTableProperties { get }
    
    func loadItems(page: Int, section: Int, searchString: String)
    
    func setupPaginatedTable()
    func reloadPaginatedTable()
    func reloadPaginatedTable(section: Int)
    func reloadPaginatedTable(section: Int, searchString: String)
    func refreshTable()
    func refreshTable(withIndicator: Bool)
    func refreshTable(withIndicator: Bool, searchString: String)
    func onTableViewWillDisplayCell(index: IndexPath, cell: UITableViewCell, searchString: String)
    func getEstimatedHeightForRowAt(index: IndexPath) -> CGFloat
}

extension PaginatedTableDisplayer where Self: SearchableTableDisplayer {
    
    func setupPaginatedTable() {
        setupStandardTable()
        setupRefreshControl()
        setupSearchBar()
    }
    
    func refreshTable() {
        refreshTable(withIndicator: true, searchString: searchBar.text ?? "")
    }
    
    func refreshTable(withIndicator: Bool) {
        refreshTable(withIndicator: withIndicator, searchString: searchBar.text ?? "")
    }
    
    func reloadPaginatedTable() {
        reloadPaginatedTable(searchString: searchBar.text ?? "")
    }
    
    func reloadPaginatedTable(searchString: String) {
        endRefreshing()
        reloadStandardTable()
        removeActivityIndicatorFromFooter()
        // Since tableView.reloadData makes main thread occupied, by running setLoading inside main thread,
        // we make sure that it is run after reloadData is finished.
        DispatchQueue.main.async {
            self.tableProperties.setAllSectionsLoading(numberOfSections: self.tableView.numberOfSections,
                                                       isLoading: false)
            self.tableProperties.setRefreshing(isRefreshing: false)
            self.onTableFinishedReloading(searchString: searchString)
        }
    }
    
    func reloadPaginatedTable(section: Int) {
        reloadPaginatedTable(section: section, searchString: searchBar.text ?? "")
    }
    
    // set the search text and call onTableViewWillDisplayCell from default extension
    func onTableViewWillDisplayCell(index: IndexPath, cell: UITableViewCell) {
        onTableViewWillDisplayCell(index: index, cell: cell, searchString: searchBar.text ?? "")
    }
    
    private func setupSearchBar() {
        addSearchBarToTable()
        setSearchBarPlaceHolderText()
        searchBar.delegate = searchBarDelegateHandler
    }
    
    private func setSearchBarPlaceHolderText() {
        let placeholder = "Search"
        searchBar.placeholder = placeholder
    }
}

extension PaginatedTableDisplayer {
    
    func setupPaginatedTable() {
        setupStandardTable()
        setupRefreshControl()
    }
    
    func reloadPaginatedTable() {
        reloadPaginatedTable(searchString: "")
    }
    
    func reloadPaginatedTable(searchString: String) {
        reloadStandardTable()
        removeActivityIndicatorFromFooter()
        DispatchQueue.main.async {
            self.tableProperties.setAllSectionsLoading(numberOfSections: self.tableView.numberOfSections,
                                                       isLoading: false)
            self.tableProperties.setRefreshing(isRefreshing: false)
            self.onTableFinishedReloading(searchString: searchString)
        }
    }
    
    func reloadPaginatedTable(section: Int) {
        reloadPaginatedTable(section: section, searchString: "")
    }
    
    func reloadPaginatedTable(section: Int, searchString: String) {
        if tableProperties.willAllSectionsBeLoaded(section: section, numberOfSections: tableView.numberOfSections) {
            reloadStandardTable()
            removeActivityIndicatorFromFooter()
        }
        DispatchQueue.main.async {
            self.tableProperties.setLoading(section: section, isLoading: false)
            self.tableProperties.setRefreshing(isRefreshing: false)
            self.onTableFinishedReloading(searchString: searchString, section: section)
        }
    }
    
    func refreshTable() {
        refreshTable(withIndicator: true, searchString: "")
    }
    
    func refreshTable(withIndicator: Bool) {
        refreshTable(withIndicator: withIndicator, searchString: "")
    }
    
    func refreshTable(withIndicator: Bool, searchString: String) {
        showTableActivityIndicator(isShown: withIndicator)
        tableProperties.setRefreshing(isRefreshing: true)
        loadItemsForAllSections(searchString: searchString)
    }
    
    func onTableViewWillDisplayCell(index: IndexPath, cell: UITableViewCell, searchString: String = "") {
        tableProperties.setCellHeight(at: index, height: cell.frame.size.height)

        let presentedItemsCount = tableView.numberOfRows(inSection: index.section)
        if tableProperties.shouldLoadNextPage(index: index, presentedItemsCount: presentedItemsCount) {
            loadNextPage(section: index.section, searchString: searchString)
        }
    }
    
    func getEstimatedHeightForRowAt(index: IndexPath) -> CGFloat {
        if let height = tableProperties.getCellHeight(at: index) {
            return height
        }
        return UITableView.automaticDimension
    }
    
    private func onTableFinishedReloading(searchString: String, section: Int = 0) {
        let visibleCellCountInSection = tableView.indexPathsForVisibleRows?.filter({ $0.section == section }).count ?? 0
        if visibleCellCountInSection > 0 // if there is an error or no item, do not try to load next page
            && tableView.numberOfRows(inSection: section) <= visibleCellCountInSection
            && !tableProperties.isAllItemsLoaded(section: section) {
            loadNextPage(section: section, searchString: searchString)
        }
    }
    
    private func loadNextPage(section: Int, searchString: String) {
        tableProperties.setLoading(section: section, isLoading: true)
        loadItems(page: tableProperties.getPage(section: section), section: section, searchString: searchString)
    }
    
    private func loadItemsForAllSections(searchString: String) {
        for i in 0..<tableView.numberOfSections {
            tableProperties.setLoading(section: i, isLoading: true)
            loadItems(page: 1, section: i, searchString: searchString)
        }
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = .green
        tableView.refreshControl?.addTarget(self, action: #selector(RefreshableTable.onRefresh), for: .valueChanged)
    }
    
    private func removeActivityIndicatorFromFooter() {
        setEmptyFooter()
    }
    
    private func endRefreshing() {
        let deadline = DispatchTime.now() + .milliseconds(500) // just for better look and feel
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}
