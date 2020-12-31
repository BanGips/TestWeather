//
//  AllWeather+CoreDataProperties.swift
//  Weather
//
//  Created by BanGips on 31.12.20.
//
//

import Foundation
import CoreData


extension AllWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AllWeather> {
        return NSFetchRequest<AllWeather>(entityName: "AllWeather")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var temp: Double
    @NSManaged public var icon: String

}
