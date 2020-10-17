//
//  EmptyTableIndicatorView.swift
//  Free-Now
//
//  Created by Hasan on 17.10.20.
//

import Foundation
import UIKit

class EmptyTableIndicatorView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labelNoData: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    init(frame: CGRect, message: String) {
        super.init(frame: frame)
        initializeView()
        setMessage(message: message)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeView()
    }

    private func initializeView() {
        Bundle.main.loadNibNamed("EmptyTableIndicatorView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func setMessage(message: String) {
        labelNoData.text = message
    }
}
