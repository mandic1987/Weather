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
    case internalError
    case invalidJSON
}
