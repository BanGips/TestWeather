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
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        return destinationVC
    }
    
    static func makeWeatherViewController() -> WeatherViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        
        return destinationVC
    }
    
    static func makeCitySelectionViewController() -> SelectionCityViewController {
        let storybord = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storybord.instantiateViewController(withIdentifier: "SelectionCityViewController") as! SelectionCityViewController
        
        return destinationVC
    }
    
    static func makeIncreasedSizeDescriptionViewController() -> IncreasedSizeDescriptionViewController {
        let storybord = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationVC = storybord.instantiateViewController(withIdentifier: "IncreasedSizeDescriptionViewController") as! IncreasedSizeDescriptionViewController
        
        return destinationVC
    }
}
