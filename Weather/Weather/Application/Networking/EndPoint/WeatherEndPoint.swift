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
        return URL(string: "https://api.openweathermap.org")!
    }
    
    var path: String {
        switch self {
        case .byCity(let cityName):
            return "/data/2.5/forecast?q=\(cityName)&" + NetworkManager.WeatherAPIKey
        case .byCoordinates(let lalitude, let longitude ):
            return  "/data/2.5/forecast?lat=\(lalitude)&lon=\(longitude)&" + NetworkManager.WeatherAPIKey
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
}
