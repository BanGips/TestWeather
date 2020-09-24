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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configure(with model: MainWeatherParameters) {
        dayLabel.text = dateFormatter.convertingNextDaysDate(timeInterval: model.dt)
        tableImageView.image = getImage(name: model.weather.last!.icon)
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
