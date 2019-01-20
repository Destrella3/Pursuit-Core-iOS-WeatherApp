//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Diego Estrella III on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ForecastAPIClinet {
    static func getForecast(onCompletion: @escaping ((AppError?, [Forecast]?) -> Void)) {
        NetworkHelper.shared.performDataTask(endpointURLString: "https://api.aerisapi.com/forecasts/[:action]?client_id=\(AerisSecretKeys.AccessID)&client_secret=\(AerisSecretKeys.APIKey)", httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                onCompletion(appError, nil)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    onCompletion(AppError.badStatusCode("\(statusCode)"), nil)
                    return
            }
            if let data = data {
                do {
                    let forecast = try JSONDecoder().decode([Forecast].self, from: data)
                    onCompletion(nil, forecast)
                } catch {
                    onCompletion(AppError.decodingError(error), nil)
                }
            }
        }
    }
}
