//
//  MapViewController.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Map"
    }
    
    private func annotation(latitude: Double, longitude: Double) {
        let annotation = PinGeolocation(location: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), title: "UserTap", subtitle: "")
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func tapForPutPin(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        annotation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let destinationVC = ViewControllerFactory.makeWeatherViewController()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
