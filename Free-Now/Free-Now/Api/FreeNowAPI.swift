//
//  FreeNowAPI.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import Foundation
import RxSwift

protocol FreeNowAPI {
    
    func getVehicleList(page: Int, pageSize: Int) -> Single<Vehicle>
}
