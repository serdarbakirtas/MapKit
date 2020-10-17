//
//  StandardTableDisplayer.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import Foundation
import UIKit

protocol StandardTableDisplayer {
    var tableView: UITableView { get }
    var activityIndicator: UIActivityIndicatorView { get }
    var tableDescription: TableDescription { get }
    
    func setupStandardTable()
    func reloadStandardTable()
    func showTableActivityIndicator(isShown: Bool)
    func onTableWillDisplayFooter(footerView: UIView, section: Int)
    func onTableWillDisplayHeader(headerView: UIView)
    func onFooterTitleForSection(section: Int, isEmpty: Bool) -> String?
}

extension StandardTableDisplayer where Self: BaseViewController {
    
    var activityIndicator: UIActivityIndicatorView {
        activityIndicatorForTables
    }
}

extension StandardTableDisplayer {
    
    func setupStandardTable() {
        tableView.keyboardDismissMode = .onDrag
        setEmptyFooter()
        addActivityIndicator()
    }
    
    func reloadStandardTable() {
        tableView.reloadData()
        showOrHideEmptyTableIndicator()
        showTableActivityIndicator(isShown: false)
    }
    
    func showTableActivityIndicator(isShown: Bool) {
        if isShown {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func onTableWillDisplayFooter(footerView: UIView, section: Int) {
        bringActivityIndicatorFront(section: section)
        changeFooterLabelAppearanceToLookLikeSecondaryText(footerView: footerView)
    }
    
    func onTableWillDisplayHeader(headerView: UIView) {
        if let header = headerView as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .black
            header.tintColor = .white
        }
    }
    
    func onFooterTitleForSection(section: Int, isEmpty: Bool) -> String? {
        if isEmpty && tableView.numberOfSections > 1 { // if only one section, message shown as background view
            return "noDataFound"
        }
        return nil
    }
    
    // table views without footer shows infinite empty list with separators, this is added to remove that effect
    func setEmptyFooter() {
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
    }
    
    private func bringActivityIndicatorFront(section: Int) {
        // if table has section headers/footers, without this line activity indicator placed behind them
        if section == 0 {
            tableView.bringSubviewToFront(activityIndicator)
        }
    }
    
    private func changeFooterLabelAppearanceToLookLikeSecondaryText(footerView: UIView) {
        if let footer = footerView as? UITableViewHeaderFooterView {
            footer.textLabel?.font = footer.textLabel?.font.withSize(12.0)
            footer.textLabel?.textColor = .black
            footer.tintColor = .white
        }
    }
    
    private func showOrHideEmptyTableIndicator() {
        let isEmptyTable = (getAllPresentedItemsCount() == 0)
        if isEmptyTable, tableView.numberOfSections == 1 {
            let labelEmpty = "noDataFound"
            tableView.backgroundView = EmptyTableIndicatorView(frame: tableView.bounds, message: labelEmpty)
            tableView.backgroundView?.transform = tableView.transform
        } else {
            tableView.backgroundView = nil
        }
    }
    
    private func getAllPresentedItemsCount() -> Int {
        var count = 0
        for section in 0..<tableView.numberOfSections {
            count += tableView.numberOfRows(inSection: section)
        }
        return count
    }
    
    private func addActivityIndicator() {
        activityIndicator.color = .green
        tableView.addSubview(activityIndicator)
        tableView.bringSubviewToFront(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        activityIndicator.topAnchor
            .constraint(equalTo: tableView.topAnchor, constant: 16).isActive = true
    }
}
