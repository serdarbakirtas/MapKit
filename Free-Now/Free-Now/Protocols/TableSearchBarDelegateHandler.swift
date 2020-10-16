//
//  TableSearchBarDelegateHandler.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import Foundation
import UIKit

class TableSearchBarDelegateHandler: NSObject, UISearchBarDelegate {
    
    weak var searchableTable: SearchableTableDisplayer!
    
    init(searchableTable: SearchableTableDisplayer) {
        self.searchableTable = searchableTable
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(onSearch), object: nil)
        self.perform(#selector(onSearch), with: nil, afterDelay: 0.3)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchableTable.resetSearchBar()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(onSearch), object: nil)
        searchableTable.onSearch()
    }
    
    @objc func onSearch() {
        searchableTable.onSearch()
    }
}
