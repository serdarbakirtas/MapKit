//
//  APIError.swift
//
//  Created by Hasan on 16.10.20.
//

struct APIError: Error {
    let message: String
    let code: StatusCode
    
    init(message: String, code: StatusCode) {
        self.message = message
        self.code = code
    }
    
    init(message: String, code: Int) {
        self.message = message
        self.code = StatusCode(rawValue: code) ?? .NONE
    }
}

enum StatusCode: Int {
    case NONE = 0
    case NOT_FOUND = 404
}
