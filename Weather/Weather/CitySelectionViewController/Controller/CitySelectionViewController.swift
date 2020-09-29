//
//  CitySelectionViewController.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

class CitySelectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private let cellID = "CustomCityNameCollectionViewCell"
    
    private let items = [Item.minsk.rawValue,
                         Item.brest.rawValue,
                         Item.hroda.rawValue,
                         Item.mogilev.rawValue,
                         Item.vitebsk.rawValue,
                         Item.homel.rawValue]
    
    private let itemsImage = [UIImage(named: Image.minsk.rawValue),
                              UIImage(named: Image.brest.rawValue),
                              UIImage(named: Image.hrodna.rawValue),
                              UIImage(named: Image.mogilev.rawValue),
                              UIImage(named: Image.vitebsk.rawValue),
                              UIImage(named: Image.homel.rawValue)]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "City selection"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CustomCityNameCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: cellID)
//        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 10
    }
    
}

extension CitySelectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        guard let customCell = cell as? CustomCityNameCollectionViewCell else { return cell }
        customCell.cityNameLabel.text = items[indexPath.item]
        customCell.cityEmblemImage.image = itemsImage[indexPath.item]
        
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: collectionView.bounds.height * 0.32)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userTap = items[indexPath.item]
        
        WeatherNetworkService.shared.getParametersForURL(string: userTap, coord: nil)
        let destinationVC = ViewControllerFactory.makeWeatherViewController()
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

extension CitySelectionViewController {
    enum Item: String {
        case minsk = "Minsk"
        case brest = "Brest"
        case hroda = "Hrodna"
        case mogilev = "Mogilev"
        case vitebsk = "Vitebsk"
        case homel = "Homel"
    }
    
    enum Image: String {
        case minsk = "minsk"
        case brest = "brest"
        case hrodna = "hrodna"
        case mogilev = "mogilev"
        case vitebsk = "vitebsk"
        case homel = "homel"
    }
}
