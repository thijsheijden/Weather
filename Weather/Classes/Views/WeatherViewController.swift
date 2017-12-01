//
//  ViewController.swift
//  Weather
//
//  Created by Thijs van der Heijden on 11/25/17.
//  Copyright © 2017 Thijs van der Heijden. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

final class WeatherViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak private var rainLabel: UILabel!
    @IBOutlet weak private var cloudinessLabel: UILabel!
    @IBOutlet weak private var windSpeedLabel: UILabel!
    @IBOutlet weak private var weatherIcon: UIImageView!
    @IBOutlet weak private var cityLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var roundedShadowView: roundedViewClass!
    @IBOutlet weak private var lessRoundedView: roundedViewClass!
    
    // MARK: Constants and Variables
    private let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    private let APP_ID = "f66339fb95d71679725ea7838ff16193"
    private let locationManager = CLLocationManager()
    
    // MARK: View-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Helper functions
    private func getWeatherData(url: String, parameters: [String:String]) {
        
        //Sending a request to the openweather API
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            if response.result.isSuccess {
                print("Weather data received succesfully")
                
                // parse and use data
                guard let responseValue = response.result.value else { return }
                
                let json = JSON(responseValue)
                if let tempResult = json["main"]["temp"].double {
                    
                    let dataModel = WeatherDataModel(json: json, tempResult: tempResult)
                    self.updateUIWith(weatherDataModel: dataModel)
                    
                } else {
                    self.cityLabel.text = "Weather Unavailable"
                }
                
            } else {
                print("Error \(response.result.error)")
                self.cityLabel.text = "Internet connection failed"
            }
        }
    }
    
    private func updateWeatherData(json: JSON) {
        
    }
    
    private func updateUIWith(weatherDataModel weatherDataModel: WeatherDataModel) {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        windSpeedLabel.text = "\(weatherDataModel.windSpeed) km/h"
        cloudinessLabel.text = "\(weatherDataModel.cloudiness)%"
        rainLabel.text = "\(weatherDataModel.rain3h) mm/cm²"
    }
    
}

// MARK: CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // If the location fails to be found
        cityLabel.text = "Location unavailable"
    }
}
