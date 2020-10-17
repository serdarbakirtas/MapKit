//
//  PaginatedTableDisplayerMock.swift
//  Free-NowTests
//
//  Created by Hasan on 17.10.20.
//

import Foundation
@testable import Free_Now
import UIKit

protocol PaginatedTableDisplayerMock: PaginatedTableDisplayer {}

extension PaginatedTableDisplayerMock {
    
    var tableView: UITableView {
        UITableView()
    }
    
    var activityIndicator: UIActivityIndicatorView {
        UIActivityIndicatorView()
    }
    
    var tableDescription: TableDescription {
        TableDescription(singleDescription: "")
    }
    
    var tableProperties: PaginatedTableProperties {
        PaginatedTableProperties()
    }
    
    func loadItems(page: Int, section: Int, searchString: String) {}
}
