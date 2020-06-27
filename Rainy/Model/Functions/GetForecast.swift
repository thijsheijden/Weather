//
//  GetForecast.swift
//  Rainy
//
//  Created by Thijs van der Heijden on 25/06/2020.
//

import Foundation

func requestForecast(location: (Double, Double), completion: @escaping (WeatherForecast) -> Void) {
    if let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(location.0)&lon=\(location.1)&appid=\(API_KEY)") {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let forecast = try JSONDecoder().decode(WeatherForecast.self, from: data)
                    completion(forecast)
                } catch let err {
                    print(err)
                }
            }
        }.resume()
    }
}
