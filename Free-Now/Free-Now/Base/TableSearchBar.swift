//
//  TableSearchBar.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import Foundation
import UIKit

class TableSearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        searchBarStyle = .minimal
        returnKeyType = .done
        autocapitalizationType = .none
        showsCancelButton = false
        enablesReturnKeyAutomatically = false
        backgroundColor = .white
        
        setTextColor()
    }
    
    private func setTextColor() {
        if let textfield = value(forKey: "searchField") as? UITextField {
            textfield.textColor = .black
        }
    }
    
    func inject(to view: UIView, with tableView: UITableView) {
        guard !view.subviews.contains(self) else { return }
        guard let tableSuperViewConstraints = tableView.superview?.constraints else { return }
        
        if let stackView = tableView.superview as? UIStackView {
            guard !stackView.subviews.contains(self) else { return }
            if let tableIndex = stackView.arrangedSubviews.firstIndex(of: tableView) {
                stackView.insertArrangedSubview(self, at: tableIndex)
            }
        } else {
            self.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(self)

            for constraint in tableSuperViewConstraints where constraint.firstAnchor == tableView.topAnchor {
                if let yAnchorOfViewAboveTable = constraint.secondAnchor as? NSLayoutAnchor<NSLayoutYAxisAnchor> {
                    tableView.superview?.removeConstraint(constraint)
                    self.topAnchor.constraint(equalTo: yAnchorOfViewAboveTable).isActive = true
                }
            }
            self.bottomAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        }
    }
}
