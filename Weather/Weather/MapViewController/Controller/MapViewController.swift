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
    var coordinate: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupUI()
    }
    
    private func makeAnnotation(coordinate: CLLocationCoordinate2D ) -> MKPointAnnotation {
       let annotation = MKPointAnnotation()
        annotation.title = "UserPin"
        annotation.coordinate = coordinate
        return annotation
    }
    
    private func setupUI() {
        title = "Map"
        
        let button = UIBarButtonItem(title: "Check", style: .plain, target: self, action: #selector(actionSetting))
        navigationItem.rightBarButtonItem = button
    }
    
    @IBAction func tapForPutPin(_ sender: UITapGestureRecognizer) {
        if annotation != nil { mapView.removeAnnotation(annotation) }
        
        let point = sender.location(in: mapView)
        coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        annotation = makeAnnotation(coordinate: coordinate)
        mapView.addAnnotation(annotation)
    }
    
    @objc func actionSetting() {
        let destinationVC = ViewControllerFactory.makeWeatherViewController()
        destinationVC.location = coordinate
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}
