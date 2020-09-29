//
//  DecodeModel.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

struct DecodeModel: Decodable {
    var list: [MainWeatherParameters]
    var city: CityName
}

struct MainWeatherParameters: Decodable {
    var dt: TimeInterval
    var main: TempParameters
    var wind: WindParameters
    var weather: [DescriptionWeather]
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

