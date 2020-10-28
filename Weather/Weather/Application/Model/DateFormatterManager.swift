//
//  DateFormatter.swift
//  Weather2
//
//  Created by BanGips on 9/15/20.
//  Copyright © 2020 BanGips. All rights reserved.
//

import Foundation
import UIKit

class DateFormatterManager {
    
    static let shared = DateFormatterManager()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
    
    func convertingCurrentDayDate(timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.string(from: date)

        return dateString
    }

    func convertingNextDaysDate(timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval )
        dateFormatter.dateFormat = "E, d MMM yyyy"
        let dateString = dateFormatter.string(from: date)

        return dateString
    }
}

