//
//  VehicleListViewModel.swift
//  Free-Now
//
//  Created by Hasan on 15.10.20.
//

import Foundation
import UIKit

struct VehicleListViewModel {
    
    var type: String?
    var state: String?
    var latitude: Double?
    var longitude: Double?
    var stateColor: UIColor?
    
    init(from items: PoiList) {
        type = getVehicleTypeName(items: items)
        state = getVehicleState(items: items)
        latitude = getLatitude(items: items)
        longitude = getLongitude(items: items)
        stateColor = getStateColor(items: items)
    }
        
    func getVehicleTypeName(items: PoiList) -> String {
        return items.type.rawValue
    }
    
    func getVehicleState(items: PoiList) -> String {
        return items.state.rawValue
    }
    
    func getLatitude(items: PoiList) -> Double {
        return items.coordinate?.latitude ?? 0
    }
    
    func getLongitude(items: PoiList) -> Double {
        return items.coordinate?.longitude ?? 0
    }
    
    func getStateColor(items: PoiList) -> UIColor {
        if items.state == .ACTIVE {
            return .green
        }
        return .black
    }
}
