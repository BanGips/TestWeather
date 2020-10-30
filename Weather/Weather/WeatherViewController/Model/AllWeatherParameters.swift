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
}

struct MainWeatherParameters: Decodable {
    var date: Double
    var main: TempParameters
    var wind: WindParameters
    var weather: [DescriptionWeather]
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case wind
        case weather
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

