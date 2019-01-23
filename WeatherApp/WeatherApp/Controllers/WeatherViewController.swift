//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Paul on 1/17/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private var forecast = [Day]() {
        didSet {
            DispatchQueue.main.async {
                self.weatherCollectionView.reloadData()
            }
        }
    }
    var location = String()
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var weatherTextField: UITextField!
    @IBOutlet weak var cityName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        weatherTextField.delegate = self
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
        if segue.identifier == "DetailSegue" {
            let detailsVC = segue.destination as! WeatherDetailViewController
            let cell = sender as! UICollectionViewCell
            let indexPaths = self.weatherCollectionView.indexPath(for: cell)
            detailsVC.forecasts = forecast[indexPaths!.row]
        }
    }
}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as?  WeatherCollectionViewCell else { return UICollectionViewCell()}
        let forecastToSet = forecast[indexPath.row]
        cell.weatherHigh.text = "High: \(forecastToSet.maxTempF)℉"
        cell.weatherLow.text = "Low: \(forecastToSet.minTempF)℉"
        cell.weatherImage.image = UIImage(named: forecastToSet.icon)
        cell.date.text = WeatherDateHelper.formatISOToDate(dateString: forecastToSet.dateTimeISO)
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 165, height: 265)
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let keyword = textField.text {
            ZipCodeHelper.getLocationName(from: keyword) { (error, string) in
                if let error = error {
                    print(error)
                } else if let string = string {
                    self.location = string
                    self.cityName.text = "Forecast for \(self.location)"
                    print(self.location)
                    ForecastAPIClinet.getForecast(zipcode: keyword, onCompletion: { (appError, day) in
                        if let appError = appError {
                            print(appError)
                        } else if let day = day {
                            self.forecast = day
                        }
                    })
                }
            }
        }
        return true
    }
}
