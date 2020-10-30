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
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        return df
    }()
    
    func convertingDate(date: Date, dateFormat: String) -> String {
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: date)

        return dateString
    }
}

//"HH:mm"
//"E, d MMM yyyy"
//"E, d MMM yyyy HH:mm"
