//
//  WeatherViewModel.swift
//  Rainy
//
//  Created by Thijs van der Heijden on 25/06/2020.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var forecast: WeatherForecast!
    
    private var locationManager: LocationManager
    private var location: (Double, Double)!
        
    init() {
        locationManager = LocationManager()
        locationManager.locationDelegate = self
    }
    
    func getForecast() {
        requestForecast(location: (location.0, location.1), completion: { forecast in
            DispatchQueue.main.async {
                self.forecast = forecast
            }
        })
    }
}

extension WeatherViewModel: LocationDelegate {
    func locationSet(location: (Double, Double)) {
        self.location = location
        getForecast()
    }
}
