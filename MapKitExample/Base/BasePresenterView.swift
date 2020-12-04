//
//  BasePresenterView.swift
//
//  Created by Hasan on 16.10.20.
//

import UIKit

protocol BasePresenterView: class {
    func showAlert(title: String?, message: String?, actions: [UIAlertAction]?)
}

class BasePresenter<T: BasePresenterView> {
    
    weak var view: T?
    var apiInstance: MapKitExampleAPI
    
    init(view: T, apiInstance: MapKitExampleAPI = MapKitExampleAPIRepo.sharedInstance) {
        self.view = view
        self.apiInstance = apiInstance
    }
    
    func interpretError(title: String?, error: Error, actions: [UIAlertAction]? = nil) {
        var message: String?
        message = error.localizedDescription
        if let apiError = error as? APIError {
            message = apiError.message
            if apiError.message.contains("URLSessionTask failed with error: ") {
                let suffixIndex = apiError.message.index(apiError.message.startIndex,
                                                         offsetBy: "URLSessionTask failed with error: ".count)
                message = String(apiError.message.suffix(from: suffixIndex))
            }
        }
        
        view?.showAlert(title: title, message: message, actions: actions)
    }
}
