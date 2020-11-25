//
//  ViewController.swift
//  Weather
//
//  Created by BanGips on 9/21/20.
//

import UIKit
import CoreLocation

class SelectMethodViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let items = RowItem.allCases
    private let cellID = "SelectMethodTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        LocationManager.shared.setupLocation()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SelectMethodTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellID)

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
            destinationVC.location = LocationManager.shared.currentLocation
            navigationController?.pushViewController(destinationVC, animated: true)
        case .checkByMap:
            let destinationVC = ViewControllerFactory.makeMapViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        case .checkPastForecast:
            let destinationVC = ViewControllerFactory.makeSavedForecastViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}

extension SelectMethodViewController {
    enum RowItem: String, CaseIterable {
        case checkByCity = "Check by name of city"
        case checkByMap = "Check by map"
        case checkByGeo = "Check by geolocation"
        case checkPastForecast = "Check past forecast"
    }
}

