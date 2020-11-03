//
//  WeatherCollectionViewCell.swift
//  Weather
//
//  Created by BanGips on 10/21/20.
//

import UIKit
import Kingfisher

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!

    private let dataFormatter = DateFormatterManager.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(time: Date, image: URL?, temperature: Double) {
        imageView.kf.setImage(with: image)
        timeLabel.text = dataFormatter.convertingDate(date: time, dateFormat: "HH:mm")
        tempLabel.text = "\(Int(temperature))°"
    }
}
