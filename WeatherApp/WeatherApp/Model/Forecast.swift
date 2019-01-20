//
//  Forcast.swift
//  WeatherApp
//
//  Created by Diego Estrella III on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    let response: [ForecastData]
}

struct ForecastData: Codable {
    let maxTempF: Int
    let minTempF: Int
    let precipIN: Int
    let windGustMPH: Int
    let weather:  String
    let icon: String
    let sunrise: Int
    let sunset: Int
}
