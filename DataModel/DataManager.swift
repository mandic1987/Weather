//
//  DataManager.swift
//  Weather
//
//  Created by iOS on 12/26/17.
//  Copyright © 2017 WoodCode. All rights reserved.
//

import Foundation

typealias Callback = (City?, [Forecast]?, DataError?) -> Void

final class DataManager {
    static let shared = DataManager()
    private let networkManager = WeatherNetworkManager()
    private let imageNetworkManager = ImageNetworkManager()
    
    private init () {
        
    }
}

extension DataManager {
    func search(for name: String, dataCallback: @escaping Callback) {
        let path: WeatherNetworkManager.Path = .name(n: name)
        
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
                DispatchQueue.main.async {
                    dataCallback(city, forecast, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    dataCallback(nil, nil, DataError.noData)
                }
            }
        }
    }
}

extension DataManager {
    func getWeatherByLocation(for latitude: Double, longitude: Double, dataCallback: @escaping Callback) {
        let path: WeatherNetworkManager.Path = .coordinates(lat: latitude, lon: longitude)
        
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
                DispatchQueue.main.async {
                    dataCallback(city, forecast, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    dataCallback(nil, nil, DataError.noData)
                }
            }
        }
    }
}

extension DataManager {
    typealias ICallback = ([Image]?, DataError?) -> Void
    
    func searchImage(for name: String, dataCallback: @escaping ICallback) {
        let path: ImageNetworkManager.Path = .name(name: name)
        
        imageNetworkManager.call(path: path) {
            json, networkError in
            
            if let networkError = networkError {
                dataCallback(nil, DataError.networkError(networkError))
            }
            
            guard let json = json else {
                dataCallback(nil, DataError.invalidJSON)
                return
            }
            
            do {
                let imageURL: [Image] = try json.value(for: "photos")
                DispatchQueue.main.async {
                    dataCallback(imageURL, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    dataCallback(nil, DataError.noData)
                }
            }
        }
    }
}
