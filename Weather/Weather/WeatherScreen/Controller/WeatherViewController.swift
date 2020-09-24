//
//  WeatherViewController.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var collectionViewForWeather: UICollectionView!
    @IBOutlet weak var tableViewForWeather: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var mainTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    private var dataSourceForTableView = [MainWeatherParameters]()
    private var dataSourceForCollectView = [MainWeatherParameters]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewForWeather.delegate = self
        collectionViewForWeather.dataSource = self
        collectionViewForWeather.register(UINib(nibName: "CustomWeatherCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cellCVWeather")

        tableViewForWeather.delegate = self
        tableViewForWeather.dataSource = self
        tableViewForWeather.register(UINib(nibName: "CustomWeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cellTVWeather")
        
        
        
        WeatherNetworkService.shared.getWeather { [self] (response) in
            let dataSource = response.list
            print(response.city.name)
            
            dataSourceForTableView = [dataSource[8], dataSource[16], dataSource[24], dataSource[32]]
            dataSourceForCollectView.append(contentsOf: dataSource[0...7])
            tableViewForWeather.reloadData()
            collectionViewForWeather.reloadData()
            cityNameLabel.text = response.city.name
            mainTempLabel.text = "\(Int(dataSourceForCollectView.first!.main.temp))°"
            humidityLabel.text = "Humidity: \(dataSource.first!.main.humidity)%"
            windLabel.text = "Wind m/s: \(dataSource.first!.wind.speed)"
            descriptionLabel.text = "\(dataSource.first!.weather.first!.description)"
        }
    }
    
    
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSourceForCollectView.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCVWeather", for: indexPath)
        guard let customCell = cell as? CustomWeatherCollectionViewCell else { return cell }
        customCell.configure(with: dataSourceForCollectView[indexPath.item])
        
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 85, height: collectionView.bounds.height)
    }


}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataSourceForTableView.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTVWeather", for: indexPath)
        guard let customCell = cell as? CustomWeatherTableViewCell else { return cell }
        customCell.configure(with: dataSourceForTableView[indexPath.row])
        customCell.backgroundColor = .clear
        
        return customCell
    }


}
