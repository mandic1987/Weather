//
//  NetworkError.swift
//  Weather
//
//  Created by iOS on 12/27/17.
//  Copyright © 2017 WoodCode. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case urlError(URLError)
    case invalidResponse
    case noData
}
