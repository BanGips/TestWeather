//
//  SavedWeatherTableViewCell.swift
//  Weather
//
//  Created by BanGips on 30.11.20.
//

import UIKit

class SavedWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    static let cellID = "SavedWeatherTableViewCell"
}
