//
//  CustomWeatherTableViewCell.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tableImageView: UIImageView!
    
    private let dateFormatter = DateFormatterModel.shared
    private let weatherImage = WeatherNetworkService.shared
    
    func configure(date: TimeInterval, temperature: Double) {
        dayLabel.text = dateFormatter.convertingNextDaysDate(timeInterval: date)
//        tableImageView.image = weatherImage.getImage(name: model.weather.last!.icon)
        tempLabel.text = "\(Int(temperature))°"
    }

    
}
