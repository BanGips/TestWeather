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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewForWeather.delegate = self
        collectionViewForWeather.dataSource = self
        collectionViewForWeather.register(UINib(nibName: "CustomWeatherCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cellCVWeather")

        tableViewForWeather.delegate = self
        tableViewForWeather.dataSource = self
        tableViewForWeather.register(UINib(nibName: "CustomWeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cellTVWeather")
    }
    
    
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCVWeather", for: indexPath)
        guard let customCell = cell as? CustomWeatherCollectionViewCell else { return cell }
        customCell.contentView.backgroundColor = .blue

        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 85, height: collectionView.bounds.height)
    }


}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTVWeather", for: indexPath)
        guard let customCell = cell as? CustomWeatherTableViewCell else { return cell }
        
        return customCell
    }


}
