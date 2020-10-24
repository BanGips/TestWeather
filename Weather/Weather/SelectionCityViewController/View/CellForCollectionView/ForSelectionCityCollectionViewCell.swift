//
//  CustomCityNameCollectionViewCell.swift
//  Weather
//
//  Created by BanGips on 9/23/20.
//

import UIKit

class ForSelectionCityCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var customContentView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityEmblemImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(name: String, image: UIImage?) {
        cityNameLabel.text = name
        cityEmblemImage.image = image
    }

}
