//
//  Image.swift
//  Weather
//
//  Created by iOS on 5/11/18.
//  Copyright © 2018 WoodCode. All rights reserved.
//

import Foundation
import Marshal

final class Image: Unmarshaling {
    var imageLink: String
    
    init(object: MarshaledObject) throws {
        imageLink = try object.value(for: "src.portrait")
    }
}
