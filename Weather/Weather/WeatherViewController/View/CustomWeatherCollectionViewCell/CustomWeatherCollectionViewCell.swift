//
//  CustomWeatherCollectionViewCell.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

class CustomWeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    private let dateFormatter = DateFormatterModel.shared
    private let weatherImage = WeatherNetworkService.shared
    
    func configure(with model: MainWeatherParameters) {
        imageView.image = weatherImage.getImage(name: model.weather.last!.icon)
        timeLabel.text = dateFormatter.convertingCurrentDayDate(timeInterval: model.dt)
        tempLabel.text = "\(Int(model.main.temp))°"
    }
    
}
