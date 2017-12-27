//
//  NetworkManager.swift
//  Weather
//
//  Created by iOS on 12/26/17.
//  Copyright © 2017 WoodCode. All rights reserved.
//

import Foundation

final class NetworkManager {
    enum  Path {
        static let host = "http://api.openweathermap.org/data/2.5/forecast/daily"
        static let count = "7"
        static let apiKey = "59f3ee883bd98efaba93fe0f4a8cf516"
        
        case name(n: String)
        case id(id: Int)
        case coordinates(lat: Double, lon: Double)
        case zipCode(zip: Int)
        
        private var url: URL {
            var s = ""
            
            switch self {
            case .name(let n):
                s = "\(Path.host)?q=\(n)&cnt=\(Path.count)&appid=\(Path.apiKey)"
            case .id(let id):
                s = "\(Path.host)?id=\(id)&cnt=\(Path.count)&appid=\(Path.apiKey)"
            case .coordinates(let lat, let lon):
                s = "\(Path.host)?lat=\(lat)&lon=\(lon)&cnt=\(Path.count)&appid=\(Path.apiKey)"
            case .zipCode(let zip):
                s = "\(Path.host)?zip=\(zip)&appid=\(Path.apiKey)"
            }
         
            return URL(string: s)!
        }
        
        private var method: String {
            switch self {
            case .name:
                return "GET"
            case .id:
                return "GET"
            case .coordinates:
                return "GET"
            case .zipCode:
                return "GET"
            }
        }
        
        var urlRequest: URLRequest {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method
            return urlRequest
        }
    }

}