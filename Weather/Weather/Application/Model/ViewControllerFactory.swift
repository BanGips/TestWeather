//
//  ViewControllerFactory.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

struct ViewControllerFactory {
    
    static func makeMapViewController() -> MapViewController {
        let storyboard = UIStoryboard(name: "MapViewController", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateInitialViewController() as! MapViewController
        
        return destinationVC
    }
    
    static func makeWeatherViewController() -> WeatherViewController {
        let storyboard = UIStoryboard(name: "WeatherViewController", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateInitialViewController() as! WeatherViewController
        
        return destinationVC
    }
    
    static func makeCitySelectionViewController() -> CitySelectionViewController {
        let storyboard = UIStoryboard(name: "CitySelectionViewController", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateInitialViewController() as! CitySelectionViewController
        
        return destinationVC
    }
}
