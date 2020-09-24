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
    
    func configure(with model: MainWeatherParameters) {
        imageView.image = getImage(name: model.weather.last!.icon)
        timeLabel.text = dateFormatter.convertingCurrentDayDate(timeInterval: model.dt)
        tempLabel.text = "\(Int(model.main.temp))°"
    }
    
    private func getImage(name: String) -> UIImage {
        let string = "https://openweathermap.org/img/wn/\(name)@2x.png"
        let stringURL = URL(string: string)
        
        let data = try? Data(contentsOf: stringURL!)
        let image = UIImage(data: data!)
        
        return image!
    }
    
}
