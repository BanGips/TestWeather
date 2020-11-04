//
//  EndPointType.swift
//  Weather
//
//  Created by BanGips on 11/4/20.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}
