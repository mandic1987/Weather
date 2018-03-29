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
    
    func populateCell(withWeather weather: Forecast) {
        guard let max = NumberFormatter.tempFormatter.string(for: weather.maxTempC) else { return }
        guard let min = NumberFormatter.tempFormatter.string(for: weather.minTempC) else { return }
        guard let date = DateFormatter.localeTimeFormatter.string(for: weather.date) else { return }
        
        tempLabel.text = "\(max)°C/\(min)°C"
        daysLabel.text = date
        
        for item in weather.icon {
            iconImage.image = UIImage(named: item)
        }
    }
}
