//
//  VehicleMapPresenter.swift
//  Free-Now
//
//  Created by Hasan on 15.10.20.
//

import Foundation
import RxSwift

class VehicleMapPresenter<T: VehicleMapView>: BasePresenter<T> {
    
    // MARK: PROPERTIES
    
    override init(view: T, shareApiInstance: FreeNowAPI = FreeNowAPIRepo.sharedInstance) {
        super.init(view: view, shareApiInstance: shareApiInstance)
    }
}
