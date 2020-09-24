//
//  CitySelectionViewController.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

class CitySelectionViewController: UIViewController {
    @IBOutlet weak var cityNamesCollectionView: UICollectionView!
    
    private let citiesArray = ["Minsk", "Brest", "Grodno", "Mogilev", "Vitebsk", "Gomel" ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNamesCollectionView.delegate = self
        cityNamesCollectionView.dataSource = self
        cityNamesCollectionView.register(UINib(nibName: "CustomCityNameCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cityNamesCV")
        
    }
    
}

extension CitySelectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return citiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cityNamesCollectionView.dequeueReusableCell(withReuseIdentifier: "cityNamesCV", for: indexPath)
        guard let customCell = cell as? CustomCityNameCollectionViewCell else { return cell }
        customCell.cityNameLabel.text = citiesArray[indexPath.item]
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 180, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userTap = citiesArray[indexPath.item]
        WeatherNetworkService.shared.getParametersForURL(string: userTap, coord: nil)
        let destinationVC = ViewControllerFactory.makeWeatherViewController()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
}
