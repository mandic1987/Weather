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
            return nil
        case .invalidResponse:
            return nil
        case .noData:
            return "No Data to show"
        case .invalidJSON:
            return "Invalid JSON"
        }
    }
    
    var message: String? {
        switch self {
        case .networkError(let error):
            return error.description
        case .invalidResponse:
            return "Invalid response"
        case .noData:
            return nil
        case .invalidJSON:
            return nil
        }
    }
}
