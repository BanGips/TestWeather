//
//  CustomWeatherTableViewCell.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit
import Kingfisher

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tableImageView: UIImageView!

    private let dateFormatter = DateFormatterManager.shared
    
    func configure(date: Date, image: URL?, temperature: Double) {
        dayLabel.text = dateFormatter.convertingDate(date: date, dateFormat: "E, d MMM yyyy")
        tableImageView.kf.setImage(with: image)
        tempLabel.text = "\(Int(temperature))°"
    }

    
}
