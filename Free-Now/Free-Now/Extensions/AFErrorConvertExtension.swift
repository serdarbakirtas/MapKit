//
//  AFErrorConvertExtension.swift
//  Free-Now
//
//  Created by Hasan on 16.10.20.
//

import Alamofire

extension AFError {
    
    func getAsAPIError(responseData: Data?) -> APIError {
        if self.isResponseValidationError {
            var errorMessage = ""
            if let data = responseData, let message = String(data: data, encoding: .utf8) {
                errorMessage = message
            }
            return APIError(message: errorMessage, code: responseCode ?? 0)
        }
        return APIError(message: localizedDescription, code: .NONE)
    }
}
