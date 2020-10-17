//
//  SearchableTableDisplayerMock.swift
//  Free-NowTests
//
//  Created by Hasan on 17.10.20.
//

import Foundation
@testable import Free_Now
import UIKit

protocol SearchableTableDisplayerMock: SearchableTableDisplayer {}

extension SearchableTableDisplayerMock {
    
    var searchBar: UISearchBar {
        UISearchBar()
    }
    
    var searchBarDelegateHandler: TableSearchBarDelegateHandler {
        TableSearchBarDelegateHandler(searchableTable: self)
    }
    
    func addSearchBarToTable() {}
}
