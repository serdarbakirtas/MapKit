//
//  CustomTableViewCell.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSelectedBackgroundView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSelectedBackgroundView()
    }
    
    func configureSelectedBackgroundView() {
        let view = UIView()
        view.backgroundColor = .green
        selectedBackgroundView = view
    }
}
