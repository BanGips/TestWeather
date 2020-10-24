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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var dataSourceForTableView = [MainWeatherParameters]()
    private var weatherParameters: DecodeModel?
    private var weatherParam: [RowItem] = []
    
    private let containerCellID = "ContainerTableViewCell"
    private let tableViewCellID = "WeatherTableViewCell"
    
    var cityName: String?
    var location: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        getWeatherParameters()
        setupActivityIndicator()

    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: tableViewCellID)
        tableView.register(UINib(nibName: "ContainerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: containerCellID)
        
        let headerNib = UINib(nibName: "HeaderView", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "HeaderView")
    }
    
    private func getWeatherParameters() {
        WeatherNetworkService.shared.getWeather(cityName: cityName, coordinate: location) { [unowned self] (weatherData, error) in
            if error != nil {
                showAlert(description: error!.localizedDescription)

            } else if let weatherData = weatherData {
                self.weatherParameters = weatherData
//                self.dataSourceForTableView.append(contentsOf: weatherData.list)
//                self.tableView.reloadData()

                for item in weatherData.list {
                    let currentDayData = RowItem.curentDayWeather(timeInterval: item.dt, temrepature: item.main.temp)
                    weatherParam.append(currentDayData)
                }

                for item in weatherData.list {
                    let nextDayData = RowItem.nextDayWeather(timeInterval: item.dt, temrepature: item.main.temp)
                    weatherParam.append(nextDayData)
                }
                self.tableView.reloadData()
                
            }
            
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setupActivityIndicator() {
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        activityIndicator.startAnimating()
    }
    
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! tableHeader
        tableHeader.configure(parameters: weatherParameters)
        
        return tableHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherParam.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch weatherParam[indexPath.row] {
        
        case .curentDayWeather(timeInterval: let timeInterval, temrepature: let temrepature):
            let cell = tableView.dequeueReusableCell(withIdentifier: containerCellID, for: indexPath) as! ContainerTableViewCell
//            cell.dataSourceCollectionView = dataSourceForTableView

            return cell
        case .nextDayWeather(timeInterval: let timeInterval, temrepature: let temrepature):
            let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath) as! WeatherTableViewCell
//            cell.configure(with: dataSourceForTableView[indexPath.row])
            cell.backgroundColor = .clear
            
            return cell
        }
        
        
//        let rowSetup = indexPath.row
//        if rowSetup == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: containerCellID, for: indexPath) as! ContainerTableViewCell
//            cell.dataSourceCollectionView = dataSourceForTableView
//
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath) as! WeatherTableViewCell
//            cell.configure(with: dataSourceForTableView[indexPath.row])
//            cell.backgroundColor = .clear
//
//            return cell
//        }
        
    }
    
}

extension WeatherViewController {
    enum RowItem {
        case curentDayWeather(timeInterval: TimeInterval, temrepature: Double)
        case nextDayWeather(timeInterval: TimeInterval, temrepature: Double)
    }
    
}


