//
//  CitySelectionViewController.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

class SelectionCityViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let cellID = "ForSelectionCityCollectionViewCell"
    private let items: [RowItem] = [.item(name: "Minsk", image: UIImage(named: "minsk")),
                                    .item(name: "Brest", image: UIImage(named: "brest")),
                                    .item(name: "Hrodna", image: UIImage(named: "hrodna")),
                                    .item(name: "Mogilev", image: UIImage(named: "mogilev")),
                                    .item(name: "Vitebsk", image: UIImage(named: "vitebsk")),
                                    .item(name: "Homel", image: UIImage(named: "homel"))]
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupUI()
        
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ForSelectionCityCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: cellID)
    }
    
    private func setupUI() {
        title = "City selection"
    }
    
}

extension SelectionCityViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        guard let weatherCell = cell as? ForSelectionCityCollectionViewCell else { return cell }
        
        let item = items[indexPath.row]
        switch item {
        case let .item(name, image):
            weatherCell.cityNameLabel.text = name
            weatherCell.cityEmblemImage.image = image
        }
        return weatherCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = collectionView.bounds.width / 2 - 10
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userTap = items[indexPath.item]
        
        switch userTap {
        case let .item(name, _):
            let destinationVC = ViewControllerFactory.makeWeatherViewController()
            destinationVC.cityName = name
            navigationController?.pushViewController(destinationVC, animated: true)
            
        }
    }
    
}

extension SelectionCityViewController {
    enum RowItem {
        case item(name: String, image: UIImage!)
    }
}

