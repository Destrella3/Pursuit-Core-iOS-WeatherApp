//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private var forecast = [WeatherForWeek]() {
        didSet {
            DispatchQueue.main.async {
                self.weatherCollectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var weatherTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCollectionView.dataSource = self
        uploadData()
    }
    
    private func uploadData() {
        ForecastAPIClinet.getForecast(zipcode: "10027") { (appError, forecast) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let forecast = forecast {
                self.forecast = forecast
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as?  WeatherCollectionViewCell else { return UICollectionViewCell()}
        let forecastToSet = forecast[indexPath.row].periods
        cell.weatherHigh.text = "High: \(forecastToSet![indexPath.row].maxTempF ?? 0)℉"
        cell.weatherLow.text = "Low: \(forecastToSet![indexPath.row].minTempF ?? 0)℉"
        cell.date.text = forecastToSet![indexPath.row].dateTimeISO
        cell.weatherImage.image = UIImage(named: "blizzard") 
        return cell
    }
}
