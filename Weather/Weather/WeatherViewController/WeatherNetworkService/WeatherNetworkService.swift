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
    
    private var cityName: String?
    private var coordinate: CLLocationCoordinate2D!
    
    func getParametersForURL(string: String?, coord: CLLocationCoordinate2D?) {
        guard let coordinate = coord else { return }
        self.coordinate = coordinate
        cityName = string
      
    }
    
    private func setupURL() -> String {
        if cityName != nil {
            if let city = cityName {
                return "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=43eb687365c30bfd88ebe5bf42cf46d1&&units=metric"
            }
        }
        return "https://api.openweathermap.org/data/2.5/forecast?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=43eb687365c30bfd88ebe5bf42cf46d1&units=metric"
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
    
    func getImage(name: String) -> UIImage {
        let string = "https://openweathermap.org/img/wn/\(name)@2x.png"
        let stringURL = URL(string: string)
        
        let data = try! Data(contentsOf: stringURL!)
        let image = UIImage(data: data)
        
        return image!
    }
    
}


