//
//  DateHelper.swift
//  WeatherApp
//
//  Created by Diego Estrella III on 1/20/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct WeatherDateHelper {
    static func formatISOToDate(dateString: String) -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = dateString
        if let date = isoDateFormatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
        
    }
    static func formatISOToTime(dateString: String) -> String {
        let isoDateFormatter = ISO8601DateFormatter()
        var formattedDate = dateString
        if let date = isoDateFormatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
    static func formatMoreInfo(dailyForecast: Day) -> String {
        return "High: \(dailyForecast.maxTempF)°F \nLow: \(dailyForecast.minTempF)°F \nSunrise: \(WeatherDateHelper.formatISOToTime(dateString: dailyForecast.sunriseISO)) \nSunset: \(WeatherDateHelper.formatISOToTime(dateString: dailyForecast.sunsetISO)) \nWindspeed: \(dailyForecast.windSpeedMaxMPH) MPH \nPrecipitation: \(dailyForecast.precipIN) in"
    }
}
