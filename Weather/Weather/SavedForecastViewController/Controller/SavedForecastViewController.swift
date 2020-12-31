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
    private let coreData = CoreDataService()
    
    private var savedForecast = [RowItem]()
    private var result = [AllWeatherParameters]()
    
    private let cellID = "SavedWeatherTableViewCell"
    
    private var timeState = TimeSate.even
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupUI()
        getSavedForecast()
    
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SavedWeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellID)
        
    }
    
    private func setupUI() {
        let button = UIBarButtonItem(title: "DeleteAll", style: .plain, target: self, action: #selector(onDeleteAllButtonPress))
        navigationItem.rightBarButtonItem = button
    }
    
    private func getSavedForecast() {
        let mitune = getMinutes()

        if mitune % 2 == 0 {
            timeState = .even
            getSavedForecastRealm()
        } else {
            timeState = .notEven
            getSavedForecastCoreData()
        }
    }
    
    @objc func onDeleteAllButtonPress() {
        
        switch timeState {
        case .even:
            realm.deleteAll()
        case .notEven:
            coreData.deleteAll()
        }
        
        savedForecast.removeAll()
        tableView.reloadData()
    }
    
    // MARK: - Realm
    
    private func getSavedForecastRealm() {
        result = realm.read(type: AllWeatherParameters.self).sorted { $0.city.name.lowercased() < $1.city.name.lowercased() }
        
        for item in result {
            if let icon = item.mainParameters.first?.weatherList.first {
                
                let url = URL(string: "https://openweathermap.org/img/wn/\(icon.icon)@2x.png")
                let savedWeather = RowItem.savedForecast(city: item.city.name, imageURL: url, temrepature: item.mainParameters.first?.main.temp)
                savedForecast.append(savedWeather)
            }
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Core Data
    
    private func getSavedForecastCoreData() {
        let result = coreData.read().sorted { $0.name.lowercased() < $1.name.lowercased() }
        
        for item in result {
                let url = URL(string: "https://openweathermap.org/img/wn/\(item.icon)@2x.png")
            
            let savedWeather = RowItem.savedForecast(city: item.name, imageURL: url, temrepature: item.temp)
                savedForecast.append(savedWeather)
            
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Date component
    
    private func getMinutes() -> Int {
        let date = Date()
        let calendar = Calendar.current
        
        return calendar.component(.minute, from: date)
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
        
        switch timeState {
        case .even:
            let selectedItem = result.remove(at: indexPath.row)
            realm.deleteObject(selectedItem)
            
            savedForecast.removeAll()
            getSavedForecastRealm()
        case .notEven:
            let selectedCity = savedForecast[indexPath.row]
            switch selectedCity {
            case let .savedForecast(city, _, _):
                coreData.deleteObject(name: city)
            }
            savedForecast.removeAll()
            getSavedForecastCoreData()
        }
        
        self.tableView.reloadData()
    }
    
}

extension SavedForecastViewController {
    
    enum RowItem {
        case savedForecast(city: String, imageURL: URL?, temrepature: Double?)
    }
    
    enum TimeSate {
        case even
        case notEven
    }
}
