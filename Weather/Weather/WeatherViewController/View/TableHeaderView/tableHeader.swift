//
//  HeaderView.swift
//  Weather
//
//  Created by BanGips on 10/21/20.
//

import UIKit

class tableHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    func configure( parameters: DecodeModel?) {
        guard let testedParameters = parameters else { return }
        
        cityLabel.text = testedParameters.city.name
        temperatureLabel.text = "\(Int(testedParameters.list.first!.main.temp))°"
        humidityLabel.text = "Humidity: \(testedParameters.list.first!.main.humidity)%"
        windLabel.text = "Wind m/s: \(testedParameters.list.first!.wind.speed)"
        descriptionLabel.text = "\(testedParameters.list.first!.weather.first!.description)"
    }
    
    
    
}
