//
//  SearchableTableDisplayer.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import Foundation
import UIKit

protocol SearchableTableDisplayer: class {
    var searchBar: UISearchBar { get }
    var searchBarDelegateHandler: TableSearchBarDelegateHandler { get }
    
    func addSearchBarToTable()
    func onSearch()
    func resetSearchBar()
}

extension SearchableTableDisplayer {
    
    func resetSearchBar() {
        searchBar.text?.removeAll()
        searchBar.endEditing(true)
    }
}

extension SearchableTableDisplayer where Self: PaginatedTableDisplayer {
    
    func onSearch() {
        showTableActivityIndicator(isShown: true)
        refreshTable(withIndicator: true, searchString: searchBar.text ?? "")
    }
}
