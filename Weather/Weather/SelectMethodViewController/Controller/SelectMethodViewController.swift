//
//  ViewController.swift
//  Weather
//
//  Created by BanGips on 9/21/20.
//

import UIKit

class SelectMethodViewController: UIViewController {
    @IBOutlet weak var TableView: UITableView!
    private let items = [RowItem.checkByCity.rawValue, RowItem.checkByGeo.rawValue, RowItem.checkByMap.rawValue]
    private let cellID = "CustomTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Selection screen"
        
        TableView.delegate = self
        TableView.dataSource = self
        TableView.register(UINib(nibName: "CustomTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellID)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Geolocation.shared.setupLocation()
    }
    
}

extension SelectMethodViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let customCell = cell as? CustomTableViewCell else { return cell }
        customCell.modeSelectionWeatherLabel.text = items[indexPath.row]
        customCell.backgroundColor = .clear
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch items[indexPath.row] {
        case RowItem.checkByCity.rawValue:
            let destinationVC = ViewControllerFactory.makeCitySelectionViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        case RowItem.checkByGeo.rawValue:
            let destinationVC = ViewControllerFactory.makeWeatherViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        case RowItem.checkByMap.rawValue:
            let destinationVC = ViewControllerFactory.makeMapViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        default:
            break
        }
    }
}

extension SelectMethodViewController {
    enum RowItem: String {
        case checkByMap = "Check by map"
        case checkByGeo = "Check by geolocation"
        case checkByCity = "Check by name of city"
    }
}

