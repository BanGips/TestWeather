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
    
    private var headWeatherParameters: DecodeModel?
    private var weatherDataSource: [RowItem] = []
    
    private let containerCellID = "ContainerTableViewCell"
    private let tableViewCellID = "WeatherTableViewCell"
    private let minorWeaherCelID = "MinorWeatherTableViewCell"
    
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
        tableView.register(UINib(nibName: "MinorWeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: minorWeaherCelID)
        
        let headerNib = UINib(nibName: "TableHeader", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "TableHeader")
    }
    
    private func getWeatherParameters() {
        WeatherNetworkService.shared.getWeather(cityName: cityName, coordinate: location) { [unowned self] (weatherData, error) in
            if error != nil {
                showAlert(description: error!.localizedDescription)

            } else if let weatherData = weatherData {
                self.headWeatherParameters = weatherData

                let curentDayWeather = RowItem.curentDayWeather(weatherParameters: weatherData.list)
                weatherDataSource.append(curentDayWeather)

                for item in weatherData.list {
                    let nextDayData = RowItem.nextDayWeather(date: item.dt, temrepature: item.main.temp)
                    weatherDataSource.append(nextDayData)
            
                }
                
                let minorWeather = RowItem.minorWeather(humidity: weatherData.list.first!.main.humidity, wind: weatherData.list.first!.wind.speed)
                weatherDataSource.append(minorWeather)
                
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
        let tableHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeader") as! TableHeader
        tableHeader.configure(parameters: headWeatherParameters)
        
        return tableHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 150 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch weatherDataSource[indexPath.row] {
        case let .curentDayWeather(weatherParameters):
            let cell = tableView.dequeueReusableCell(withIdentifier: containerCellID, for: indexPath) as! ContainerTableViewCell
            cell.dataSourceCollectionView = weatherParameters

            return cell
        case let .nextDayWeather(timeInterval, temrepature):
            let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath) as! WeatherTableViewCell
            cell.configure(date: timeInterval, temperature: temrepature)
            cell.backgroundColor = .clear
            
            return cell
        case let .minorWeather(humidity, wind):
            let cell = tableView.dequeueReusableCell(withIdentifier: minorWeaherCelID, for: indexPath) as! MinorWeatherTableViewCell
            cell.configure(humidity: humidity , wind: wind)
            
            return cell
        }
    
    }
    
}

extension WeatherViewController {
    enum RowItem {
        case curentDayWeather(weatherParameters: [MainWeatherParameters])
        case nextDayWeather(date: TimeInterval, temrepature: Double)
        case minorWeather(humidity: Int, wind: Double)
    }
    
}


