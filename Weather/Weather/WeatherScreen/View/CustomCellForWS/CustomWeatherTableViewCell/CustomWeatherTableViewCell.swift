//
//  CustomWeatherTableViewCell.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

class CustomWeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tableImageView: UIImageView!
    
    private let dateFormatter = DateFormatterModel.shared
    private let weatherImage = WeatherNetworkService.shared
    
    func configure(with model: MainWeatherParameters) {
        dayLabel.text = dateFormatter.convertingNextDaysDate(timeInterval: model.dt)
        tableImageView.image = weatherImage.getImage(name: model.weather.last!.icon)
        tempLabel.text = "\(Int(model.main.temp))°"
    }
    
}
