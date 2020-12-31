//
//  SavedForecastViewController.swift
//  Weather
//
//  Created by BanGips on 25.11.20.
//

import UIKit
import Kingfisher

class SavedForecastViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let realm = RealmService()
    private var savedForecast = [RowItem]()
    private var result = [AllWeatherParameters]()
    
    private let cellID = "SavedWeatherTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        getSavedForecast()
        setupUI()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SavedWeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellID)
        
    }
    
    private func setupUI() {
        let button = UIBarButtonItem(title: "DeleteAll", style: .plain, target: self, action: #selector(actionSetting))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func actionSetting() {
        realm.deleteAll()
        savedForecast.removeAll()
        tableView.reloadData()
    }
    
    private func getSavedForecast() {
        result = realm.getObject(type: AllWeatherParameters.self).sorted { $0.city.name.lowercased() < $1.city.name.lowercased() }
        
        for item in result {
            if let icon = item.mainParameters.first?.weatherList.first {
                
                let url = URL(string: "https://openweathermap.org/img/wn/\(icon.icon)@2x.png")
                let savedWeather = RowItem.savedForecast(city: item.city.name, imageURL: url, temrepature: item.mainParameters.first?.main.temp)
                savedForecast.append(savedWeather)
            }
        }
        
        tableView.reloadData()
    }

}

extension SavedForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SavedWeatherTableViewCell
        switch savedForecast[indexPath.row] {
        case .savedForecast(let city, let url, let temp):
            cell.dayLabel.text = city
            cell.weatherIconImageView.kf.setImage(with: url)
            cell.temperatureLabel.text = temp?.description
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let selectedItem = result.remove(at: indexPath.row)
        realm.deleteObject(selectedItem)
        
        savedForecast.remove(at: indexPath.row)
        self.tableView.reloadData()
    }
    
}

extension SavedForecastViewController {
    
    enum RowItem {
        case savedForecast(city: String, imageURL: URL?, temrepature: Double?)
    }
}
