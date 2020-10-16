//
//  VehicleMapController.swift
//  Free-Now
//
//  Created by Hasan on 15.10.20.
//

import MapKit
import UIKit

protocol VehicleMapView: BaseView {}

class VehicleMapController: BaseViewController {
    
    var presenter: VehicleMapPresenter<VehicleMapController>!
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = VehicleMapPresenter(view: self)
    }
}

extension VehicleMapController: VehicleMapView {}
