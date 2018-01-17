//
//  Forecast.swift
//  Weather
//
//  Created by iOS on 12/27/17.
//  Copyright © 2017 WoodCode. All rights reserved.
//

import Foundation
import Marshal

final class Forecast: Unmarshaling {
    
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Double
    let pressure: Double
    let wind: Double
    let description: [String]
    let icon: [String]
    
    init(object: MarshaledObject) throws {
        temp = try object.value(for: "temp.day")
        tempMax = try object.value(for: "temp.max")
        tempMin = try object.value(for: "temp.min")
        humidity = try object.value(for: "humidity")
        pressure = try object.value(for: "pressure")
        wind = try object.value(for: "speed")
        description = try object.value(for: "weather.description")
        icon = try object.value(for: "weather.icon")
    }

}
