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

    private let dateFormatter = DateFormatterModel.shared
    
    func configure(date: TimeInterval, image: URL, temperature: Double) {
        dayLabel.text = dateFormatter.convertingNextDaysDate(timeInterval: date)
        tableImageView.kf.setImage(with: image)
        tempLabel.text = "\(Int(temperature))°"
    }

    
}
