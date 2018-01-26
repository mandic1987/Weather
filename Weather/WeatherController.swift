//
//  WeatherController.swift
//  Weather
//
//  Created by iOS on 11/19/17.
//  Copyright © 2017 WoodCode. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {

    var dataManager: DataManager = .shared
    private var weathers: [Forecast] = []
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func search(for name: String) {
        dataManager.search(for: name) {
            city, forecasts, dataError  in
            
            if let _ = dataError {
                return
            }
            
            self.weathers = forecasts!
            self.table.reloadData()
        }
    }
}

extension WeatherController {
    @IBAction func textFieldChanged(_ sender: UITextField) {
        guard let s = sender.text else { return }
        search(for: s)
        print(s)
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
