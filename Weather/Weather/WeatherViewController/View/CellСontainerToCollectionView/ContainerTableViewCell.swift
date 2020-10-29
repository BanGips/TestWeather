//
//  ContainerTableViewCell.swift
//  Weather
//
//  Created by BanGips on 10/21/20.
//

import UIKit

protocol ContainerTableViewCellDelegate: AnyObject {
    func segueToDescriptionViewController(time: Double, imageURL: URL, temperature: Double)
}

class ContainerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: ContainerTableViewCellDelegate?

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
    
    func configure(weatherParameters: [MainWeatherParameters]) {
        
        for item in weatherParameters {
            guard let icon = item.weather.last else { return }
            guard let url = URL(string: "https://openweathermap.org/img/wn/\(icon.icon)@2x.png") else { return }
            
            let currentDayWeather = RowItem.item(time: item.date, imageURL: url, temperature: item.main.temp)
            dataSourceCollectionView.append(currentDayWeather)
            collectionView.reloadData()
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
        case let .item(time, imageULR, temperature):
            weatherCell.configure(time: time, image: imageULR, temperature: temperature)
        }
        
        return weatherCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 4.4, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userTap = dataSourceCollectionView[indexPath.item]
        switch userTap {
        case let .item(time, imageURL, temperature):
            delegate?.segueToDescriptionViewController(time: time, imageURL: imageURL, temperature: temperature)
        }

    }
}

extension ContainerTableViewCell {
    enum RowItem {
        case item(time: Double, imageURL: URL, temperature: Double)
    }
}
