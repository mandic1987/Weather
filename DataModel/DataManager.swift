//
//  DataManager.swift
//  Weather
//
//  Created by iOS on 12/26/17.
//  Copyright © 2017 WoodCode. All rights reserved.
//

import Foundation

final class DataManager {
    static let shared = DataManager()
    private let networkManager = NetworkManager()
    
    private init () {
        
    }
}

extension DataManager {
    func search(for name: String, dataCallback: @escaping ([Forecast], DataError?) -> Void) {
        let path: NetworkManager.Path = .name(n: name)
        
        networkManager.call(path: path) { json, networkError in
            
            if let networkError = networkError {
                dataCallback([], DataError.networkError(networkError))
            }
            
            guard let json = json else { return }
            
            dataCallback([], nil)
        }
        
    }
}
