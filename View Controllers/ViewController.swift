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

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "f66339fb95d71679725ea7838ff16193"
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var roundedShadowView: roundedViewClass!
    @IBOutlet weak var lessRoundedView: roundedViewClass!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: Networking
    func getWeatherData(url: String, parameters: [String:String]) {
        //Sending a request to the openweather API
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Weather data received succesfully")
                
                let weatherJSON : JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
                
            } else {
                print("Error \(response.result.error)")
                self.cityLabel.text = "Internet connection failed"
            }
        }
    }
    
    
    //MARK: JSON Parsing
    func updateWeatherData(json : JSON) {
        if let tempResult = json["main"]["temp"].double {

        weatherDataModel.temperature = Int(tempResult - 273.15)
        weatherDataModel.city = json["name"].stringValue
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
        updateUIWithWeatherData()
        } else {
            cityLabel.text = "Weather Unavailable"
        }
    }
    
    
    //MARK: UI Updates
    func updateUIWithWeatherData() {
        
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }
    
    
    
    
    //MARK: Location manager delegate methods
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

    
    //If the location fails to be found
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location unavailable"
    }
    
}

