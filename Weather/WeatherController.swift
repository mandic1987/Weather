//
//  WeatherController.swift
//  Weather
//
//  Created by iOS on 11/19/17.
//  Copyright © 2017 WoodCode. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var current: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var minMax: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var wind: UILabel!
    
    var dataManager: DataManager = .shared
    private var weathers: [Forecast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func search(for name: String) {
        dataManager.search(for: name) {
            city, forecasts, dataError  in
            
            if let _ = dataError {
                return
            }
            
            self.populate(with: city!, weather: forecasts!)
            self.weathers = forecasts!
            self.table.reloadData()
        }
    }
}

extension WeatherController {
    func populate(with town: City, weather: [Forecast]) {
        let currentWeather = weather.first!
        
        city.text = town.name
        date.text = "\(currentWeather.date)"
        current.text = "\(currentWeather.tempC)°C"
        minMax.text = "\(currentWeather.maxTempC)°C/\(currentWeather.minTempC)°C"
        humidity.text = "\(currentWeather.humidity)%"
        pressure.text = "\(currentWeather.pressure)hPa"
        wind.text = "\(currentWeather.wind)kph"
        
        for des in currentWeather.description {
            desc.text = des
        }
        
        for img in currentWeather.icon {
            icon.image = UIImage(named: img)
        }
    }
}

extension WeatherController {
    @IBAction func search(_ sender: UIButton) {
        guard let s = textField.text, s.count > 2 else { return }
        search(for: s)
        textField.resignFirstResponder()
    }
}

extension WeatherController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherCell = table.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let weather = weathers[indexPath.row]
        cell.populate(withWeather: weather)
        
        return cell
    }
}
