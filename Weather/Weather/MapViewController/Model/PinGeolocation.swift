//
//  Geolocation.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit
import MapKit

class PinGeolocation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(location: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = location
        self.title = title
        self.subtitle = subtitle
    }
}
