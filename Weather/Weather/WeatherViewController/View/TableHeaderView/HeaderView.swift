//
//  HeaderView.swift
//  Weather
//
//  Created by BanGips on 10/21/20.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    func configure( parameters: DecodeModel?) {
        guard let testedResponse = parameters else { return }
        
        cityLabel.text = testedResponse.city.name
        temperatureLabel.text = "\(Int(testedResponse.list.first!.main.temp))°"
        humidityLabel.text = "Humidity: \(testedResponse.list.first!.main.humidity)%"
        windLabel.text = "Wind m/s: \(testedResponse.list.first!.wind.speed)"
        descriptionLabel.text = "\(testedResponse.list.first!.weather.first!.description)"
    }
    
    
    
}
