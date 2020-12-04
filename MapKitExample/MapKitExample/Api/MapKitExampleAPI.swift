//
//  MapKitExampleAPI.swift
//
//  Created by Hasan on 16.10.20.
//

import Foundation
import RxSwift

protocol MapKitExampleAPI {
    
    func getVehicleList() -> Single<Vehicle>
    
    func getVehicleListWithLocation(p2latitude: Double, p1longitude: Double, p1latitude: Double, p2longitude: Double) -> Single<Vehicle>
}
