//
//  BasePresenterView.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import Alamofire

protocol BasePresenterView: class {
    func showAlert(title: String?, message: String?, actions: [UIAlertAction]?)
}

class BasePresenter<T: BasePresenterView> {
    
    weak var view: T?
    var shareApiInstance: FreeNowAPI
    
    init(view: T, shareApiInstance: FreeNowAPI = FreeNowAPIRepo.sharedInstance) {
        self.view = view
        self.shareApiInstance = shareApiInstance
    }
    
    func interpretError(title: String?, error: Error, actions: [UIAlertAction]? = nil) {
        var message: String?
        message = error.localizedDescription
        if let apiError = error as? APIError {
            if let json = try? JSONSerialization.jsonObject(with: apiError.message.data(using: .utf8)!, options: []) {
                if let dict = json as? [String: Any] {
                    if let nonFieldErrors = dict["nonFieldErrors"] as? [String] {
                        message = nonFieldErrors.first
                    } else if let fieldErrors = dict["fieldErrors"] as? [String] {
                        message = fieldErrors.first
                    } else if let detail = dict["detail"] as? String {
                        message = detail
                    } else if let errorMessage = dict["message"] as? String {
                        message = errorMessage
                    } else {
                        let key = dict.keys.first ?? "Missing Key"
                        var value = "Unknown Error Message"
                        if let dictValue = (dict.values.first as? [String])?.first {
                            value = dictValue
                        } else if let innerDict = dict.values.first as? [String: Any],
                            let dictValue = (innerDict.values.first as? [String])?.first {
                            value = dictValue
                        }
                        message = "\(key): \(value)"
                    }
                } else if let array = json as? [String] {
                    message = array.first
                }
            } else {
                message = apiError.message
                if apiError.message.contains("URLSessionTask failed with error: ") {
                    let suffixIndex = apiError.message.index(apiError.message.startIndex,
                                                             offsetBy: "URLSessionTask failed with error: ".count)
                    message = String(apiError.message.suffix(from: suffixIndex))
                }
            }
        }
        
        view?.showAlert(title: title, message: message, actions: actions)
    }
}
