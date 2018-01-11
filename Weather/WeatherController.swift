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
            forecasts, dataError in
            
            if let dataError = dataError {
                return
            }
            
            self.forecast = forecasts
        }
    }
}
