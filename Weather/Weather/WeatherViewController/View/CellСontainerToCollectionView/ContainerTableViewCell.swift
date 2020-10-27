//
//  ContainerTableViewCell.swift
//  Weather
//
//  Created by BanGips on 10/21/20.
//

import UIKit

class ContainerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSourceCollectionView = [RowItem]()
    private let collectionViewID = "WeatherCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
       
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "WeatherCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: collectionViewID )
    }
    
    func getData(weatherParameters: [MainWeatherParameters]) {
        for item in weatherParameters {
            let currentDayWeather = RowItem.item(time: item.date, temperature: item.main.temp)
            dataSourceCollectionView.append(currentDayWeather)
        }
    }
    
}

extension ContainerTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSourceCollectionView.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewID, for: indexPath)
        guard let weatherCell = cell as? WeatherCollectionViewCell else { return cell }
        
        switch dataSourceCollectionView[indexPath.item] {
        case let .item(time, temperature):
            weatherCell.configure(time: time, temperature: temperature)
        }
        
        return weatherCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 4.4, height: collectionView.bounds.height)
    }
    
}

extension ContainerTableViewCell {
    enum RowItem {
        case item(time: Double, temperature: Double)
    }
}
