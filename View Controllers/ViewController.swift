//
//  ViewController.swift
//  Weather
//
//  Created by Thijs van der Heijden on 11/25/17.
//  Copyright © 2017 Thijs van der Heijden. All rights reserved.
//

import UIKit


class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "f66339fb95d71679725ea7838ff16193"
    
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var roundedShadowView: roundedViewClass!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return cell
    }
    
    
}

