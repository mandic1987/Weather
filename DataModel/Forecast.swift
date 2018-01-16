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
    let cityID: Int
    let name: String
    let temp: Double
    let description: String
    let icon: String
    let tempMin: Double
    let tempMax: Double
    let humidity: Double
    let pressure: Double
    let wind: Double
    
    init(object: MarshaledObject) throws {
        cityID = try object.value(for: "id")
        name = try object.value(for: "name")
        temp = try object.value(for: "id")
        description = try object.value(for: "name")
        icon = try object.value(for: "email")
        tempMax = try object.value(for: "id")
        tempMin = try object.value(for: "name")
        humidity = try object.value(for: "email")
        pressure = try object.value(for: "id")
        wind = try object.value(for: "name")
    }

}

