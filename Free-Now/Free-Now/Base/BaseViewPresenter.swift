//
//  BaseViewPresenter.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import Foundation

class BaseViewPresenter<T: BaseView>: BasePresenter<T> {
    
    override init(view: T, apiInstance: FreeNowAPI = FreeNowAPIRepo.sharedInstance) {
        super.init(view: view, apiInstance: apiInstance)
    }
}
