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
    
    var annotation: MKPointAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Map"
    }
    
    private func makeAnnotation(coordinate: CLLocationCoordinate2D ) -> MKPointAnnotation {
       let annotation = MKPointAnnotation()
        annotation.title = "UserPin"
        annotation.coordinate = coordinate
        return annotation
    }
    
    @IBAction func tapForPutPin(_ sender: UITapGestureRecognizer) {
        if annotation != nil { mapView.removeAnnotation(annotation) }
        
        let point = sender.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        annotation = makeAnnotation(coordinate: coordinate)
        mapView.addAnnotation(annotation)

        let destinationVC = ViewControllerFactory.makeWeatherViewController()
        destinationVC.location = coordinate
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
