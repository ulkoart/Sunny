//
//  ViewController.swift
//  Sunny
//
//  Created by Ivan Akulov on 24/02/2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) {
            cityName in
            self.networkWeatherManager.fetchCurrentWeather(forCity: cityName) { currentWeather in
                print(currentWeather)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        networkWeatherManager.fetchCurrentWeather(forCity: "Krasnodar")
    }
}


