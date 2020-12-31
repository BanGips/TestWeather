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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
