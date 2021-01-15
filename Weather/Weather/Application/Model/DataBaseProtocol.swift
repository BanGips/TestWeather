//
//  DataBaseProtocol.swift
//  Weather
//
//  Created by BanGips on 4.01.21.
//

import Foundation

protocol DataBaseProtocol {
    func create(_ object: AllWeatherParameters)
    func read() -> [DataFormDataBase]
    func deleteAll()
    func deleteObject(id: Int)
}

