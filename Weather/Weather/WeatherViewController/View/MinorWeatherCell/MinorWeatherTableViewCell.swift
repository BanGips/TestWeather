//
//  MinorWeatherTableViewCell.swift
//  Weather
//
//  Created by BanGips on 10/26/20.
//

import UIKit

class MinorWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(humidity: Int, wind: Double) {
        humidityLabel.text = "Humidity: \(humidity)%"
        windLabel.text = "Wind m/s: \(wind)"
    }
    
}
