//
//  NetworkWeatherManager.swift
//  Sunny
//
//  Created by user on 05/08/2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import UIKit
import CoreLocation

protocol NetworkWeatherManagerDelegate: class {
    func updateInterface(_: NetworkWeatherManager, with currentWeather: CurrentWeather)
}

class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    var onComplition: ((CurrentWeather) -> Void)?
    weak var delegate: NetworkWeatherManagerDelegate?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"

        }
        
        print(urlString)
        
        perfomeRequest(withURLString: urlString)
    }   
   
    fileprivate func perfomeRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
               let session = URLSession(configuration: .default)
               let task = session.dataTask(with: url) {data, response, error in
                   if let data = data {
                       if let currentWeather = self.parseJSON(withData: data) {
                           //                    self.delegate?.updateInterface(self, with: currentWeather)
                           self.onComplition?(currentWeather)
                       }
                   }
               }
               task.resume()
    }
    
    
    
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
