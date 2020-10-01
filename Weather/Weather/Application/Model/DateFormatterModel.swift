//
//  DateFormatter.swift
//  Weather2
//
//  Created by BanGips on 9/15/20.
//  Copyright © 2020 BanGips. All rights reserved.
//

import Foundation
import UIKit

class DateFormatterModel {
    
    static let shared = DateFormatterModel()
    
    private var dateFormatter: DateFormatter?
    
    func convertingCurrentDayDate(timeInterval: TimeInterval) -> String {
        let date = Date.init(timeIntervalSince1970: timeInterval)
        dateFormatter = DateFormatter()
        dateFormatter?.dateFormat = "HH:mm"
        let dateString = dateFormatter!.string(from: date)
           
        return dateString
    }
    
    func convertingNextDaysDate(timeInterval: TimeInterval) -> String {
        let date = Date.init(timeIntervalSince1970: timeInterval )
        dateFormatter = DateFormatter()
        dateFormatter?.dateFormat = "E, d MMM yyyy"
        let dateString = dateFormatter!.string(from: date)
        
        return dateString
    }
}
