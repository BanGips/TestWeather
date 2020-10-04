//
//  WeatherViewController.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var mainTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    private var dataSourceForTableView = [MainWeatherParameters]()
    private var dataSourceForCollectView = [MainWeatherParameters]()
    private let collectionViewCellID = "WeatherCollectionViewCell"
    private let tableViewCellID = "WeatherTableViewCell"
    
    var cityName: String?
    var location: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupCollectionView()
        setupUI()

    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: tableViewCellID)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "WeatherCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: collectionViewCellID)
    }
    
    private func setupUI() {
        WeatherNetworkService.shared.getWeather(cityName: cityName, coordinate: location) { [unowned self] (response) in
            let dataSource = response.list

            self.dataSourceForTableView = [dataSource[8], dataSource[16], dataSource[24], dataSource[32]]
            self.dataSourceForCollectView.append(contentsOf: dataSource[0...7])
            self.tableView.reloadData()
            self.collectionView.reloadData()
            self.cityNameLabel.text = response.city.name
            self.mainTempLabel.text = "\(Int(self.dataSourceForCollectView.first!.main.temp))°"
            self.humidityLabel.text = "Humidity: \(dataSource.first!.main.humidity)%"
            self.windLabel.text = "Wind m/s: \(dataSource.first!.wind.speed)"
            self.descriptionLabel.text = "\(dataSource.first!.weather.first!.description)"
        }
    }
    
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSourceForCollectView.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellID, for: indexPath)
        guard let customCell = cell as? WeatherCollectionViewCell else { return cell }
        customCell.configure(with: dataSourceForCollectView[indexPath.item])
        
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 4.5, height: collectionView.bounds.height)
    }
    
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceForTableView.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID, for: indexPath)
        guard let customCell = cell as? WeatherTableViewCell else { return cell }
        customCell.configure(with: dataSourceForTableView[indexPath.row])
        customCell.backgroundColor = .clear
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 4
    }
    
}


