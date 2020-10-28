//
//  IncreasedSizeDescriptionViewController.swift
//  Weather
//
//  Created by BanGips on 10/27/20.
//

import UIKit
import Kingfisher

class IncreasedSizeDescriptionViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    private let dateFormatter = DateFormatterModel.shared
    
    var date: Double!
    var imageURL: URL!
    var temperature: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = dateFormatter.convertingNextDaysDate(timeInterval: date)
        imageView.kf.setImage(with: imageURL)
        temperatureLabel.text = "\(Int(temperature))°"
    }
    

}
