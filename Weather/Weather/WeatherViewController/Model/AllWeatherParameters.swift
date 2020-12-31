//
//  DecodeModel.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit
import RealmSwift

class AllWeatherParameters: Object, Decodable {
    @objc dynamic var id = 0
    var mainParameters = List<MainWeatherParameters>()
    @objc dynamic var city: CityName!
    
    enum CodingKeys: String, CodingKey {
        case mainParameters = "list"
        case city
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }

}

class MainWeatherParameters: Object, Decodable {
    @objc dynamic var date: Date!
    @objc dynamic var main: TempParameters!
    @objc dynamic var wind: WindParameters!
    var weatherList = List<DescriptionWeather>()
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case wind
        case weatherList = "weather"
    }
    
}

class TempParameters: Object, Decodable {
    @objc dynamic var temp: Double
    @objc dynamic var humidity: Int
}

class WindParameters: Object, Decodable {
    @objc dynamic var speed: Double
}

class CityName: Object, Decodable {
    @objc dynamic var name: String
    @objc dynamic var id: Int
    
}

class DescriptionWeather: Object, Decodable {
    @objc dynamic var icon: String
    @objc dynamic var descrip: String

    enum CodingKeys: String, CodingKey {
        case icon
        case descrip = "description"
    }
}



//struct AllWeatherParameters: Decodable {
//    var mainParameters: [MainWeatherParameters]
//    var city: CityName
//
//    enum CodingKeys: String, CodingKey {
//        case mainParameters = "list"
//        case city
//    }
//
//}
//
//struct MainWeatherParameters: Decodable {
//    var date: Date
//    var main: TempParameters
//    var wind: WindParameters
//    var weather: [DescriptionWeather]
//
//    enum CodingKeys: String, CodingKey {
//        case date = "dt"
//        case main
//        case wind
//        case weather
//    }
//
//}
//
//struct TempParameters: Decodable {
//    var temp: Double
//    var humidity: Int
//}
//
//struct WindParameters: Decodable {
//    var speed: Double
//}
//
//struct CityName: Decodable {
//    var name: String
//}
//
//struct DescriptionWeather: Decodable {
//    var icon: String
//    var description: String
//    var main: String
//}

