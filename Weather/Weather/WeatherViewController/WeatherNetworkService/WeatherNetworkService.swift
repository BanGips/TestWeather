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
  
    func getWeather(cityName: String?, coordinate: CLLocationCoordinate2D?, completion: @escaping(DecodeModel) -> Void) {
        var urlSting = ""
        if cityName != nil {
            urlSting = Referens.title.rawValue + "q=\(cityName!)" + Referens.appid.rawValue
        } else {
            guard let coord = coordinate else { return }
            urlSting = Referens.title.rawValue + "lat=\(coord.latitude)&lon=\(coord.longitude)" + Referens.appid.rawValue
        }
        
        guard let url = URL(string: urlSting ) else { return }
        
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

extension WeatherNetworkService {
    enum Referens: String {
        case title = "https://api.openweathermap.org/data/2.5/forecast?"
        case appid = "&appid=43eb687365c30bfd88ebe5bf42cf46d1&&units=metric"
    }
}


