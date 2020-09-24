//
//  WeatherNetworkService.swift
//  Weather
//
//  Created by BanGips on 9/23/20.
//

import Foundation
import CoreLocation

class WeatherNetworkService {
    static let shared = WeatherNetworkService()
    
    var cityName: String?
    var coordinate: CLLocationCoordinate2D?
    
    func getParametersForURL(string: String?, coord: CLLocationCoordinate2D?) {
        cityName = string
        coordinate = coord
    }
    
    func printed() {
        print(coordinate?.latitude)
        print(coordinate?.longitude)
    }
    
    func getWeather(completion: @escaping(DecodeModel) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=37.33093591&lon=-122.03058916&appid=43eb687365c30bfd88ebe5bf42cf46d1&units=metric"
        
        guard let url = URL(string: urlString) else { return }
        
        NetworkService.getData(url: url) { (data) in
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(DecodeModel.self, from: data)
                completion(json)
            }
            catch {
                print(error)
            }
            
        }
            
    }
        
}
        

