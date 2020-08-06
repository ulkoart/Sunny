//
//  NetworkWeatherManager.swift
//  Sunny
//
//  Created by user on 05/08/2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import UIKit

struct NetworkWeatherManager {
    func fetchCurrentWeather(forCity city: String, completionHandler: @escaping (CurrentWeather) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                completionHandler(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) -> CurrentWeather? {
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
