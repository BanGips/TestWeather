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

        items.removeAll()
        tableView.reloadData()
    }
    
    // MARK:  Realm
    
    private func getSavedForecast() {
        let result = dataBase!.read().sorted { $0.name.lowercased() < $1.name.lowercased() }
        items = result
        tableView.reloadData()
    }
    
    
    // MARK:  Date component
    
    private func getMinutes() -> Int {
        let date = Date()
        let calendar = Calendar.current
        
        return calendar.component(.minute, from: date)
    }
    
}

extension SavedForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SavedWeatherTableViewCell
        let item = items[indexPath.row]
        
        cell.dayLabel.text = item.name
        cell.weatherIconImageView.kf.setImage(with: item.icon)
        cell.temperatureLabel.text = Int(item.temp).description + "°"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let selectedItem = items[indexPath.row].id
        dataBase?.deleteObject(id: selectedItem)
        items.removeAll()
        
        getSavedForecast()
        self.tableView.reloadData()

    }
}
