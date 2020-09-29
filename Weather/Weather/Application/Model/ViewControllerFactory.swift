//
//  ViewControllerFactory.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit


struct ViewControllerFactory {
    
    static func makeMapViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateViewController(identifier: "MapViewController")
        
        return destinationVC
    }
    
    static func makeWeatherViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateViewController(identifier: "WeatherViewController")
        
        return destinationVC
    }
    
    static func makeCitySelectionViewController() -> UIViewController {
        let storybord = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storybord.instantiateViewController(identifier: "CitySelectionViewController")
        
        return destinationVC
    }
}
