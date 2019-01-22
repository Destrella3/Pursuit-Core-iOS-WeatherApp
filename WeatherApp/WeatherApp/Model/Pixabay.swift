//
//  Pixabay.swift
//  WeatherApp
//
//  Created by Diego Estrella III on 1/21/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Pixabay: Codable {
    let hits: [PixaImages]
}

struct PixaImages: Codable {
    let largeImageURL: String
}
