//
//  AppError.swift
//  WeatherApp
//
//  Created by Diego Estrella III on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

enum APIError: Error {
    case badURL
    case networkError
    case clientError
    case serverError
    case noResponse
    case badData
}
