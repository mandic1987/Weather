//
//  WeatherController.swift
//  Weather
//
//  Created by iOS on 11/19/17.
//  Copyright © 2017 WoodCode. All rights reserved.
//

import UIKit
import CoreLocation

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
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGPSLocation()
    }

}

extension WeatherController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherCell = table.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let weather = weathers[indexPath.row]
        cell.populateCell(withWeather: weather)
        
        return cell
    }
}

extension WeatherController {
    func getWeatherWithLocation(for lat: Double, lon: Double) {
        dataManager.getWeatherByLocation(for: lat, longitude: lon) {
           [weak self] city, forecast, dataError in
            
            if let _ = dataError {
                return
            }
            
            guard let cityName = city else { return }
            guard let extForec = forecast else { return }
            
            self?.populateView(with: cityName, weather: extForec)
            self?.weathers = extForec
            self?.table.reloadData()
        }
    }

    func search(for name: String) {
        dataManager.search(for: name) {
            [weak self] city, forecasts, dataError in
            
            if let _ = dataError {
                return
            }
            
            guard let cities = city else { return }
            guard let fr = forecasts else { return }
            
            self?.populateView(with: cities, weather: fr)
            self?.weathers = fr
            self?.table.reloadData()
        }
    }

    func populateView(with town: City, weather: [Forecast]) {
        let currentWeather = weather.first!

        guard let dates = DateFormatter.localeTimeFormatter.string(for: currentWeather.date) else { return }
        guard let curr = NumberFormatter.tempFormatter.string(for: currentWeather.tempC) else { return }
        guard let max = NumberFormatter.tempFormatter.string(for: currentWeather.maxTempC) else { return }
        guard let min = NumberFormatter.tempFormatter.string(for: currentWeather.minTempC) else { return }
        guard let hum = NumberFormatter.tempFormatter.string(for: currentWeather.humidity) else { return }
        guard let pre = NumberFormatter.tempFormatter.string(for: currentWeather.pressure) else { return }
        guard let win = NumberFormatter.tempFormatter.string(for: currentWeather.wind) else { return }

        city.text = town.name
        date.text = dates
        current.text = "\(curr)°C"
        minMax.text = "\(max)°C/\(min)°C"
        humidity.text = "\(hum)%"
        pressure.text = "\(pre)mbar"
        wind.text = "\(win)m/s"
        
        for des in currentWeather.description {
            desc.text = des
        }
        
        for img in currentWeather.icon {
            icon.image = UIImage(named: img)
        }
    }
}

extension WeatherController: CLLocationManagerDelegate {
    func getGPSLocation() {
        locationManager = CLLocationManager()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        let lat = userLocation.coordinate.latitude
        let lon = userLocation.coordinate.longitude
        
        locationManager.stopUpdatingLocation()
        getWeatherWithLocation(for: lat, lon: lon)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}

extension WeatherController {
    @IBAction func search(_ sender: UIButton) {
        guard let s = textField.text, s.count > 2 else { return }
        search(for: s)
        textField.resignFirstResponder()
    }
}
