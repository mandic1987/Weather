//
//  WeatherCell.swift
//  Weather
//
//  Created by iOS on 1/25/18.
//  Copyright © 2018 WoodCode. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak private var daysLabel: UILabel!
    @IBOutlet weak private var iconImage: UIImageView!
    @IBOutlet weak private var tempLabel: UILabel!
    
    func populate(withWeather weather: Forecast) {
        tempLabel.text = "\(weather.maxTempC)/\(weather.minTempC)"
        daysLabel.text = "\(weather.date)"
        
        for item in weather.icon {
            iconImage.image = UIImage(named: item)
        }
    }
    
}
