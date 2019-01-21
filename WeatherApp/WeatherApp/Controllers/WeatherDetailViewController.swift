//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Diego Estrella III on 1/18/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    private var forecasts: Forecast!
    
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
        
        
    }
    
    
}
