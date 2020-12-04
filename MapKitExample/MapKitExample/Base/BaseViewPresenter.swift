//
//  BaseViewPresenter.swift
//
//  Created by Hasan on 16.10.20.
//

import Foundation

class BaseViewPresenter<T: BaseView>: BasePresenter<T> {
    
    override init(view: T, apiInstance: MapKitExampleAPI = MapKitExampleAPIRepo.sharedInstance) {
        super.init(view: view, apiInstance: apiInstance)
    }
}
