//
//  CurrentWeatherData.swift
//  Sunny
//
//  Created by user on 06/08/2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation

struct CurrentWeatherData: Codable {
    let main: Main
    let name: String
    let weather: [Weather]

}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}
