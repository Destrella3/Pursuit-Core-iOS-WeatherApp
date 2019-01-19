//
//  NetworkHelper.swift
//  WeatherApp
//
//  Created by Diego Estrella III on 1/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

struct NetworkRequest {
    func getJSON(urlRequest: URLRequest, onComplete: @escaping (Result<[String: Any], APIError>)-> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let unwrappedJSON = json
                    else {
                        onComplete(.failure(.badData))
                        return
                }
                onComplete(.success(unwrappedJSON))
                return
            }
            guard let response = response as? HTTPURLResponse,
                let apiError = response.apiError
                else {
                    onComplete(.failure(.noResponse))
                    return
            }
            onComplete(.failure(apiError))
        }
        return task
    }
}
