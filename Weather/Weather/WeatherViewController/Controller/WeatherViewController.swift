//
//  WeatherViewController.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSourceForTableView = [MainWeatherParameters]()
    var response: DecodeModel?
    private let containerCellID = "ContainerTableViewCell"
    private let tableViewCellID = "WeatherTableViewCell"
    
    private let headerView = HeaderView()
    
    var cityName: String?
    var location: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupUI()

    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: tableViewCellID)
        tableView.register(UINib(nibName: "ContainerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: containerCellID)
        
        let headerNib = UINib(nibName: "HeaderView", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderView")
    }
    
    private func setupUI() {
        WeatherNetworkService.shared.getWeather(cityName: cityName, coordinate: location) { [unowned self] (response) in
            self.response = response
            let dataSource = response.list
            
            self.dataSourceForTableView.append(contentsOf: dataSource[8...])
            self.tableView.reloadData()
        }
    }
    
}


extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        headerView.setupHeaderUI(response: response)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceForTableView.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowSetup = indexPath.row
        
        if rowSetup == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: containerCellID, for: indexPath) as! ContainerTableViewCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath) as! WeatherTableViewCell
            cell.configure(with: dataSourceForTableView[indexPath.row])
            cell.backgroundColor = .clear
            
            return cell
        }
        
    }
    
}


