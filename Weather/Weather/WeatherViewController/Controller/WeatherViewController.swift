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
    
    private var headWeatherParameters: AllWeatherParameters?
    private var mainWeatherParameters = [RowItem]()
    
    private let containerCellID = "ContainerTableViewCell"
    private let tableViewCellID = "WeatherTableViewCell"
    private let minorWeaherCelID = "MinorWeatherTableViewCell"
    
    var cityName: String?
    var location: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getWeatherParameters()
        setupUI()
        
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
            if let error = error {
                showAlert(description: error.localizedDescription)
                
                return
            } else if let weatherData = weatherData {
                self.headWeatherParameters = weatherData
                
                let curentDayWeather = RowItem.curentDayWeather(weatherParameters: weatherData.mainParameters)
                mainWeatherParameters.append(curentDayWeather)
                
                
                for item in weatherData.mainParameters {
                    guard let icon = item.weather.last else { return }
                    guard let url = URL(string: "https://openweathermap.org/img/wn/\(icon.icon)@2x.png") else { return }
                    
                    let nextDayData = RowItem.nextDayWeather(date: item.date, imageURL: url, temrepature: item.main.temp)
                    mainWeatherParameters.append(nextDayData)
                    
                }
                
                guard let mainParameters = weatherData.mainParameters.first else { return }
                
                let minorWeather = RowItem.minorWeather(humidity: mainParameters.main.humidity, wind: mainParameters.wind.speed)
                mainWeatherParameters.append(minorWeather)
                
                self.tableView.reloadData()
            }
            
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setupActivityIndicator() {
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        activityIndicator.startAnimating()
    }
    
    private func setupUI() {
        title = "Weather forecast"
        setupActivityIndicator()
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeader") as! TableHeader
        tableHeader.configure(parameters: headWeatherParameters)
        
        return tableHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 120 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainWeatherParameters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch mainWeatherParameters[indexPath.row] {
        case let .curentDayWeather(weatherParameters):
            let cell = tableView.dequeueReusableCell(withIdentifier: containerCellID, for: indexPath) as! ContainerTableViewCell
            cell.getData(weatherParameters: weatherParameters)
            
            return cell
        case let .nextDayWeather(date, imageURL, temrepature):
            let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath) as! WeatherTableViewCell
            cell.configure(date: date, image: imageURL, temperature: temrepature)
            cell.backgroundColor = .clear
            
            return cell
        case let .minorWeather(humidity, wind):
            let cell = tableView.dequeueReusableCell(withIdentifier: minorWeaherCelID, for: indexPath) as! MinorWeatherTableViewCell
            cell.configure(humidity: humidity , wind: wind)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userTap = mainWeatherParameters[indexPath.row]
        
        switch userTap {
        case .curentDayWeather(_):
            break
        case let .nextDayWeather(date, imageURL, temrepature):
            let destinationVC = ViewControllerFactory.makeIncreasedSizeDescriptionViewController()
            destinationVC.date = date
            destinationVC.imageURL = imageURL
            destinationVC.temperature = temrepature
            navigationController?.pushViewController(destinationVC, animated: true)
        case .minorWeather(_, _):
            break
        }
    }
}

extension WeatherViewController {
    enum RowItem {
        case curentDayWeather(weatherParameters: [MainWeatherParameters])
        case nextDayWeather(date: Double, imageURL: URL, temrepature: Double)
        case minorWeather(humidity: Int, wind: Double)
    }
    
}
