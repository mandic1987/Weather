//
//  DataError.swift
//  Weather
//
//  Created by iOS on 12/27/17.
//  Copyright © 2017 WoodCode. All rights reserved.
//

import Foundation

enum DataError: Error {
    case networkError(NetworkError)
    case noData
    case invalidJSON
    
    var title: String? {
        switch self {
        case .networkError:
            return "Network error"
        case .noData:
            return "Not found"
        case .invalidJSON:
            return "Internal Server Error"
        }
    }
    
    var message: String? {
        switch self {
        case .networkError(let originalError):
            return originalError.localizedDescription
        case .noData:
            return "No data available"
        case .invalidJSON:
            return "The server encountered an internal error and was unable to complete your request."
        }
    }
}
