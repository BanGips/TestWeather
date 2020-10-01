//
//  ViewController.swift
//  Weather
//
//  Created by BanGips on 9/21/20.
//

import UIKit
import CoreLocation

class SelectMethodViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?
    
    private let items: [RowItem] = [.checkByCity, .checkByGeo, .checkByMap]
    private let cellID = "SelectMethodTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupUI()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupLocation()
    }
    
    private func setupLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SelectMethodTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellID)

    }
    
    private func setupUI() {
        title = "Selection screen"
    }
    
}

extension SelectMethodViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let customCell = cell as? SelectMethodTableViewCell else { return cell }
        customCell.modeSelectionWeatherLabel.text = items[indexPath.row].rawValue
        customCell.backgroundColor = .clear
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch items[indexPath.row] {
        case .checkByCity:
            let destinationVC = ViewControllerFactory.makeCitySelectionViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        case .checkByGeo:
            let destinationVC = ViewControllerFactory.makeWeatherViewController()
            destinationVC.location = currentLocation
            navigationController?.pushViewController(destinationVC, animated: true)
        case .checkByMap:
            let destinationVC = ViewControllerFactory.makeMapViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}

extension SelectMethodViewController {
    enum RowItem: String {
        case checkByMap = "Check by map"
        case checkByGeo = "Check by geolocation"
        case checkByCity = "Check by name of city"
    }
}

extension SelectMethodViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first?.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { }
}

