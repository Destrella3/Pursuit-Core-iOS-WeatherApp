//
//  Forcast.swift
//  WeatherApp
//
//  Created by Diego Estrella III on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Forecast:Codable {
    let response: [WeatherForWeek]
}
struct WeatherForWeek: Codable{
    let periods: [Day]
}
struct Day:Codable {
    let dateTimeISO: String
    let maxTempF: Int
    let minTempF: Int
    let precipIN: Double
    let icon: String
    let windSpeedMaxMPH: Int
    let weather: String
    let sunriseISO: String
    let sunsetISO: String
}
