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
    
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var weatherTextField: UITextField!
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "WeatherDetailVC") as? WeatherDetailViewController else { return }
        vc.forecasts = forecast[indexPath.row]
        
    }
}

extension WeatherViewController: UITextFieldDelegate {
    
}
