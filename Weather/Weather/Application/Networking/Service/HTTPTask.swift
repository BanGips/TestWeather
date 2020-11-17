//
//  HTTPTask.swift
//  Weather
//
//  Created by BanGips on 11/4/20.
//

import Foundation

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
}
