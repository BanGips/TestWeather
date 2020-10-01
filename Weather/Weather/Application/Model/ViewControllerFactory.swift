//
//  ViewControllerFactory.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit


struct ViewControllerFactory {
    
    static func makeMapViewController() -> MapViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateViewController(identifier: "MapViewController") as! MapViewController
        
        return destinationVC
    }
    
    static func makeWeatherViewController() -> WeatherViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateViewController(identifier: "WeatherViewController") as! WeatherViewController
        
        return destinationVC
    }
    
    static func makeCitySelectionViewController() -> SelectionCityViewController {
        let storybord = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storybord.instantiateViewController(identifier: "SelectionCityViewController") as! SelectionCityViewController
        
        return destinationVC
    }
}
