//
//  MapViewController.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapViewForWeather: MKMapView!

    func annotation(latitude: Double, longitude: Double) {
        let annotation = Geolocation(location: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), title: "UserTap", subtitle: "")
        mapViewForWeather.addAnnotation(annotation)
    }
    
    @IBAction func tapForPutPin(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: mapViewForWeather)
        let coordinates = mapViewForWeather.convert(point, toCoordinateFrom: mapViewForWeather)
        annotation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
    }
    
}
