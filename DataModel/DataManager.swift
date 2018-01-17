//
//  DataManager.swift
//  Weather
//
//  Created by iOS on 12/26/17.
//  Copyright © 2017 WoodCode. All rights reserved.
//

import Foundation
import Marshal

final class DataManager {
    static let shared = DataManager()
    private let networkManager = NetworkManager()
    
    private init () {
        
    }
}

extension DataManager {
    typealias Callback = (City?, [Forecast]?, DataError?) -> Void
    
    func search(for name: String, dataCallback: @escaping Callback) {
        let path: NetworkManager.Path = .name(n: name)
        
        networkManager.call(path: path) {
            json, networkError in
            
            if let networkError = networkError {
                dataCallback(nil, nil, DataError.networkError(networkError))
            }
            
            guard let json = json else {
                dataCallback(nil, nil, DataError.invalidJSON)
                return
            }

            do {
                let city: City = try json.value(for: "city")
                let forecast: [Forecast] = try json.value(for: "list")
                dataCallback(city, forecast, nil)
            } catch let error {
                print(error)
                dataCallback(nil, nil, DataError.internalError)
            }
        }
    }
    
}
