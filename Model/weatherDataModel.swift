//
//  weatherDataModel.swift
//  Weather
//
//  Created by Thijs van der Heijden on 11/25/17.
//  Copyright © 2017 Thijs van der Heijden. All rights reserved.
//

import Foundation
import UIKit

class WeatherDataModel {

    var temperature: Int = 0
    var condition: Int = 0
    var windSpeed: Int = 0
    var cloudiness: Int = 0
    var rain3h: Int = 0
    var city: String = ""
    var weatherIconName: String = ""
    
        func updateWeatherIcon(condition: Int) -> String {
    
        switch (condition) {
    
            case 0...300 :
                return "weather-storm"
    
            case 301...500 :
                return "weather-drizzle-day"
    
            case 501...600 :
                return "weather-showers-day"
    
            case 601...700 :
                return "weather-snow-rain"
    
            case 701...771 :
                return "weather-fog"
    
            case 772...799 :
                return "weather-storm"
    
            case 800 :
                return "weather-clear"
    
            case 801...804 :
                return "weather-clouds"
    
            case 900...903, 905...1000  :
                return "weather-storm"
    
            case 903 :
                return "weather-snow"
    
            case 904 :
                return "weather-clear"
    
            default :
                return "weather-none-available"
            }
    
        }
}


