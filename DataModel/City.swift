//
//  City.swift
//  Weather
//
//  Created by iOS on 1/16/18.
//  Copyright © 2018 WoodCode. All rights reserved.
//

import Foundation
import Marshal

final class City: Unmarshaling {
    var id: Int
    var name: String
    
    init(object: MarshaledObject) throws {
        id = try object.value(for: "id")
        name = try object.value(for: "name")
    }
}
