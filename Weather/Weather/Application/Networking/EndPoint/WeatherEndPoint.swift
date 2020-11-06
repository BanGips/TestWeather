//
//  WeatherEndPoint.swift
//  Weather
//
//  Created by BanGips on 11/4/20.
//

import Foundation

public enum WeatherApi {
    case byCity(cityName: String)
    case byCoordinates(lalitude: Double, longitude: Double)
    
}

extension WeatherApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.openweathermap.org/") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .byCity:
            return "data/2.5/forecast"
        case .byCoordinates:
            return "data/2.5/forecast"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .byCity(let city):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["appid": NetworkManager.WeatherAPIKey,
                                                      "q": city,
                                                      "units":"metric"])
            
        case .byCoordinates(let lalitude, let longitude):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["appid": NetworkManager.WeatherAPIKey,
                                                      "lat": lalitude,
                                                      "lon": longitude,
                                                      "units":"metric"])
        
        }
    }
    
}
