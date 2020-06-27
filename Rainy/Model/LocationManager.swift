//
//  LocationManager.swift
//  Rainy
//
//  Created by Thijs van der Heijden on 25/06/2020.
//

import Foundation
import CoreLocation

protocol LocationDelegate {
    func locationSet(location: (Double, Double))
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    public var locationDelegate: LocationDelegate!
    
    public var gotLocation: Bool = false
    public var location: (Double, Double)! {
        didSet {
            locationDelegate.locationSet(location: location)
        }
    }
    
    override init() {
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    // MARK: Location has been updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last!.horizontalAccuracy <= locationManager.desiredAccuracy {
            locationManager.stopUpdatingLocation()
            location = (locations.last!.coordinate.latitude, locations.last!.coordinate.longitude)
        }
    }
}
