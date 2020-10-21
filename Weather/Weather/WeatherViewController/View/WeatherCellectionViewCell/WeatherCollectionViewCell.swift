//
//  WeatherCollectionViewCell.swift
//  Weather
//
//  Created by BanGips on 10/21/20.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!

    private let dataFormatter = DateFormatterModel.shared
    private let weatherImage = WeatherNetworkService.shared

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with model: MainWeatherParameters) {
        imageView.image = weatherImage.getImage(name: model.weather.last!.icon)
        timeLabel.text = dataFormatter.convertingCurrentDayDate(timeInterval: model.dt)
        tempLabel.text = "\(Int(model.main.temp))"
    }
}
