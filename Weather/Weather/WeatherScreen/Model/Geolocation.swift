//
//  Geolocation.swift
//  Weather
//
//  Created by BanGips on 9/23/20.
//

import Foundation
import CoreLocation

class Geolocation: NSObject, CLLocationManagerDelegate {
    static let shared = Geolocation()
    
    private var locationManager: CLLocationManager?
    
    func setupLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        let coordinate = currentLocation?.coordinate
        WeatherNetworkService.shared.getParametersForURL(string: nil, coord: coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { }
}
