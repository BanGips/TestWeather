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
    
    private var dataBase: DataBaseProtocol?
    private var savedForecast = [RowItem]()
    private var items = [DataFormDataBase]()
    
    private let cellID = "SavedWeatherTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupUI()
        dataBaseConfigure()
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
    
    private func dataBaseConfigure() {
        let minutes = getMinutes()
        
        if minutes % 2 == 0 {
            dataBase = RealmService()
        } else {
            dataBase = CoreDataService()
        }
    }
    
    @objc func onDeleteAllButtonPress() {
        dataBase?.deleteAll()

        savedForecast.removeAll()
        tableView.reloadData()
    }
    
    // MARK: - Realm
    
    private func getSavedForecast() {
        let result = dataBase!.read().sorted { $0.name.lowercased() < $1.name.lowercased() }
        
        for item in result {
                let savedWeather = RowItem.savedForecast(id: item.id,
                                                         city: item.name,
                                                         imageURL: item.icon,
                                                         temrepature: item.temp)
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
        case .savedForecast(_, let city, let url, let temp):
            cell.dayLabel.text = city
            cell.weatherIconImageView.kf.setImage(with: url)
            cell.temperatureLabel.text = temp?.description
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let selectedCity = savedForecast[indexPath.row]
        switch selectedCity {
        case .savedForecast(id: let id, _, _, _):
            
            dataBase?.deleteObject(id: id)
            savedForecast.removeAll()
            
            getSavedForecast()
            self.tableView.reloadData()
        }
    }
    
}

extension SavedForecastViewController {
    
    enum RowItem {
        case savedForecast(id: Int, city: String, imageURL: URL?, temrepature: Double?)
    }
}
