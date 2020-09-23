//
//  CitySelectionViewController.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

class CitySelectionViewController: UIViewController {
    @IBOutlet weak var cityNamesCollectionView: UICollectionView!
    
    private let CitiesArray = ["Minsk", "Brest", "Hrodno" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNamesCollectionView.delegate = self
        cityNamesCollectionView.dataSource = self
        cityNamesCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cityNamesCV")
        
    }
    
}

extension CitySelectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cityNamesCollectionView.dequeueReusableCell(withReuseIdentifier: "cityNamesCV", for: indexPath)
        cell.backgroundColor = .blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 180, height: 150)
    }
    
    
}
