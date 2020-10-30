//
//  DecodeModel.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

struct AllWeatherParameters: Decodable {
    var mainParameters: [MainWeatherParameters]
    var city: CityName
    
    enum CodingKeys: String, CodingKey {
        case mainParameters = "list"
        case city
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mainParameters = try container.decode([MainWeatherParameters].self, forKey: .mainParameters)
        city = try container.decode(CityName.self, forKey: .city)
        
    }
}

struct MainWeatherParameters: Decodable {
    var date: Date
    var main: TempParameters
    var wind: WindParameters
    var weather: [DescriptionWeather]
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case wind
        case weather
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(Date.self, forKey: .date)
        main = try container.decode(TempParameters.self, forKey: .main)
        wind = try container.decode(WindParameters.self, forKey: .wind)
        weather = try container.decode([DescriptionWeather].self, forKey: .weather)
    }
}

struct TempParameters: Decodable {
    var temp: Double
    var humidity: Int
}

struct WindParameters: Decodable {
    var speed: Double
}

struct CityName: Decodable {
    var name: String
}

struct DescriptionWeather: Decodable {
    var icon: String
    var description: String
    var main: String
}

