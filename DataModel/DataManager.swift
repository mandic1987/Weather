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
    func search(for name: String, dataCallback: @escaping ([Forecast], DataError?) -> Void) {
        let path: NetworkManager.Path = .name(n: name)
        
        networkManager.call(path: path) {
            json, networkError in
            
            if let networkError = networkError {
                dataCallback([], DataError.networkError(networkError))
            }
            
            guard let json = json else {
                dataCallback([], DataError.invalidJSON)
                return
            }
            
//            guard let result = json["list"] as? JSON else { return }
            
            do {
                let forecast: [Forecast] = try json.value(for: "list")
                dataCallback(forecast, nil)
            } catch let error {
                print(error)
                dataCallback([], DataError.internalError)
            }
            
            
        }
        
    }
}
