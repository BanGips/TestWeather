//
//  HeaderView.swift
//  Weather
//
//  Created by BanGips on 10/21/20.
//

import UIKit

class TableHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
  
    func configure(parameters: AllWeatherParameters?) {
        guard let testedParameters = parameters else { return }
        
        cityLabel.text = testedParameters.city.name
        temperatureLabel.text = "\(Int(testedParameters.mainParameters.first!.main.temp))°"
        descriptionLabel.text = "\(testedParameters.mainParameters.first!.weather.first!.description)"
    }
    
}
