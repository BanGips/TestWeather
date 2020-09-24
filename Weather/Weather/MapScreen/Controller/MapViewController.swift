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
        let annotation = PinGeolocation(location: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), title: "UserTap", subtitle: "")
        mapViewForWeather.addAnnotation(annotation)
    }
    
    @IBAction func tapForPutPin(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: mapViewForWeather)
        let coordinate = mapViewForWeather.convert(point, toCoordinateFrom: mapViewForWeather)
        annotation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        WeatherNetworkService.shared.getParametersForURL(string: nil, coord: coordinate)
        let destinationVC = ViewControllerFactory.makeWeatherViewController()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
