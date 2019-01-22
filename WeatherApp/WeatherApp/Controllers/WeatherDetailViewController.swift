//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Diego Estrella III on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    public var forecasts: Day!
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var forcastImage: UIImageView!
    @IBOutlet weak var weatherForcast: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var windspeed: UILabel!
    @IBOutlet weak var inchesofPercipitation: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadData()
        
    }
    private func uploadData() {
        weatherForcast.text = forecasts.weather
        highTemp.text = "High: \(forecasts.maxTempF)"
        lowTemp.text = "Low: \(forecasts.minTempF)"
        windspeed.text = "Windspeed: \(forecasts.windSpeedMaxMPH)"
        inchesofPercipitation.text = "Inches of Percipitation \(forecasts.precipIN)"
        sunrise.text = WeatherDateHelper.formatISOToTime(dateString: forecasts.sunriseISO)
        sunset.text = WeatherDateHelper.formatISOToTime(dateString: forecasts.sunsetISO)
    }
    
}
