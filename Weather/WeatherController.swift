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
    private var forecast: [Forecast] = []
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search(for: "Belgrade")
    }
    
    func search(for name: String) {
        dataManager.search(for: name) {
            city, forecasts, dataError  in
            
            if let _ = dataError {
                return
            }
            
            self.forecast = forecasts!
        }
    }
}

extension WeatherController {
    @IBAction func textFieldChanged(_ sender: UITextField) {
        guard let s = sender.text else { return }
        search(for: s)
    }
}

extension WeatherController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherCell = table.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        return cell
    }
    
    
}





