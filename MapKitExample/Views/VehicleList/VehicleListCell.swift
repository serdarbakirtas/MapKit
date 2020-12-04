//
//  VehicleListCell.swift
//
//  Created by Hasan on 16.10.20.
//

import UIKit

class VehicleListCell: UITableViewCell {
    
    @IBOutlet var labelLatitude: UILabel!
    @IBOutlet var labelLongitude: UILabel!
    @IBOutlet var labelState: UILabel!
    @IBOutlet var labelType: UILabel!
    
    func populateCell(with vehicleViewModel: VehicleListViewModel) {
        labelType.text = vehicleViewModel.type
        labelState.text = vehicleViewModel.state
        labelLatitude.text = "\(vehicleViewModel.latitude ?? 0)"
        labelLongitude.text = "\(vehicleViewModel.longitude ?? 0)"
        labelState.textColor = vehicleViewModel.stateColor
    }
}
