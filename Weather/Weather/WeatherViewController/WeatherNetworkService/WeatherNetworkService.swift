//
//  WeatherNetworkService.swift
//  Weather
//
//  Created by BanGips on 9/23/20.
//

import UIKit
import CoreLocation

class WeatherNetworkService {
    static let shared = WeatherNetworkService()
    
    let title = "https://api.openweathermap.org/data/2.5/forecast?"
    let appid = "&appid=43eb687365c30bfd88ebe5bf42cf46d1&&units=metric"
  
    func getWeather(cityName: String?, coordinate: CLLocationCoordinate2D?, completion: @escaping(AllWeatherParameters?, Error?) -> Void) {
        var urlSting = ""
        if cityName != nil {
            urlSting = title + "q=\(cityName!)" + appid
        } else {
            guard let coord = coordinate else { return }
            urlSting = title + "lat=\(coord.latitude)&lon=\(coord.longitude)" + appid
        }
        
        guard let url = URL(string: urlSting ) else { return }
        
        NetworkService.getData(url: url) { (data, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    
                    let json = try decoder.decode(AllWeatherParameters.self, from: data)
                    completion(json, nil)
                }
                catch {
                    print(error)
                }
            } else {
                completion(nil, error)
            }
            
        }
        
    }

}




