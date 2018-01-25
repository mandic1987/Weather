//
//  WeatherCell.swift
//  Weather
//
//  Created by iOS on 1/25/18.
//  Copyright © 2018 WoodCode. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
