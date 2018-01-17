//
//  WeatherController.swift
//  Weather
//
//  Created by iOS on 11/19/17.
//  Copyright © 2017 WoodCode. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {

    var dataManager: DataManager = .shared
    private var forecast: [Forecast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search(for: "Belgrade")
    }
    
    func search(for name: String) {
        dataManager.search(for: name) {
            city, forecasts, dataError  in
            
            if let _ = dataError {
                return
            }
            
            self.forecast = forecasts!
        }
    }
}
