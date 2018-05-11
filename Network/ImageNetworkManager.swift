//
//  ImageNetworkManager.swift
//  Weather
//
//  Created by iOS on 5/10/18.
//  Copyright © 2018 WoodCode. All rights reserved.
//

import Foundation

//      https://api.pexels.com/v1/search?query=

final class ImageNetworkManager {
    enum Path {
        static let host = "https://api.pexels.com/v1/search?query="
        
        case name(name: String)
        
        private var url: URL {
            var s = ""
            
            switch self {
            case .name(let n):
                if let escName = n.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) {
                    s = "\(Path.host)?q=\(escName)"
                }
                
                return URL(string: s)!
            }
        }
        
        var method: String {
            switch self {
            case .name:
                return "GET"
            }
        }
        
        var urlRequest: URLRequest {
            var urlRequest = URLRequest(url: url)
            urlRequest.allHTTPHeaderFields = ["Authorization": "563492ad6f9170000100000148698518234a4f7b9579625ba83a4f75"]
            urlRequest.httpMethod = method
            return urlRequest
        }
    }
}

extension ImageNetworkManager {
    func call(path: Path, imageNetworkCallback: @escaping (JSON?, NetworkError?) -> Void) {
        let task = URLSession.shared.dataTask(with: path.urlRequest) {
            data, urlResponse, error in
            
            if let error = error as? URLError {
                imageNetworkCallback(nil, NetworkError.networkError(originalError: error.localizedDescription))
                return
            }
            
            guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                imageNetworkCallback(nil, NetworkError.invalidResponse)
                return
            }
            
            if httpURLResponse.statusCode != 200 {
                imageNetworkCallback(nil, NetworkError.invalidResponse)
                return
            }
            
            guard let data = data else {
                imageNetworkCallback(nil, NetworkError.noData)
                return
            }
            
            guard
                let obj  = try? JSONSerialization.jsonObject(with: data, options: []),
                let json = obj as? JSON
            else {
                    imageNetworkCallback(nil, NetworkError.invalidJSON)
                    return
            }
            
            imageNetworkCallback(json, nil)
        }
        
        task.resume()
    }
}
