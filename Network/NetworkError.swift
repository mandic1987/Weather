//
//  NetworkError.swift
//  Weather
//
//  Created by iOS on 12/27/17.
//  Copyright © 2017 WoodCode. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case networkError(originalError: String)
    case invalidResponse
    case noData
    case invalidJSON
    
    var title: String? {
        switch self {
        case .networkError:
            return "Network error."
        case .invalidResponse:
            return "Bad request"
        case .noData:
            return "Not found"
        case .invalidJSON:
            return "Internal Server Error"
        }
    }
    
    var message: String? {
        switch self {
        case .networkError(let error):
            return error.description
        case .invalidResponse:
            return "There was an error loading the request. Please try again later."
        case .noData:
            return "No data available"
        case .invalidJSON:
            return "The server encountered an internal error and was unable to complete your request."
        }
    }
}
