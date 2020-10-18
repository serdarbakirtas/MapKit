//
//  FreeNowAPI.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import Foundation
import RxSwift

protocol FreeNowAPI {
    
    func getVehicleList(page: Int, searchString: String) -> Single<Vehicle>
    func getVehicleListWithLocation(p2latitude: Double, p1longitude: Double,
                                    p1latitude: Double, p2longitude: Double) -> Single<Vehicle>
}
