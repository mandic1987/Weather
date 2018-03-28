//
//  NumberFormatter.swift
//  Weather
//
//  Created by iOS on 3/27/18.
//  Copyright © 2018 WoodCode. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static let tempFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.none
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        return formatter
    }()
}
