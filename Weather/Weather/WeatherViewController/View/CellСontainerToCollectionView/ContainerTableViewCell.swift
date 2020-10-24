//
//  ContainerTableViewCell.swift
//  Weather
//
//  Created by BanGips on 10/21/20.
//

import UIKit

class ContainerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSourceCollectionView = [MainWeatherParameters]()
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
    
}

extension ContainerTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSourceCollectionView.count - 32
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewID, for: indexPath)
        guard let weatherCell = cell as? WeatherCollectionViewCell else { return cell }
        weatherCell.configure(with: dataSourceCollectionView[indexPath.row])
        
        return weatherCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 4.4, height: collectionView.bounds.height)
    }
    
}
