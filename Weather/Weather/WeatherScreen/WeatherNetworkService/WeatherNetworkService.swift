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
    
    private func setupURL() -> String {
        if cityName == nil {
            return "https://api.openweathermap.org/data/2.5/forecast?lat=\(coordinate!.latitude)&lon=\(coordinate!.longitude)&appid=43eb687365c30bfd88ebe5bf42cf46d1&units=metric"
        }
        
        return "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName!)&appid=43eb687365c30bfd88ebe5bf42cf46d1&&units=metric"
    }
    
    
    func getWeather(completion: @escaping(DecodeModel) -> Void) {
        let urlString = setupURL()
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


