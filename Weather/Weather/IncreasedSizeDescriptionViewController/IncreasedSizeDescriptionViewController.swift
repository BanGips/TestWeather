//
//  IncreasedSizeDescriptionViewController.swift
//  Weather
//
//  Created by BanGips on 10/27/20.
//

import UIKit
import Kingfisher

class IncreasedSizeDescriptionViewController: BaseViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    private let dateFormatter = DateFormatterManager.shared
    
    var date: Double?
    var imageURL: URL?
    var temperature: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI()  {
        guard let date = date,
              let imageView = imageView,
              let temperature = temperature else { return }

        dateLabel.text = dateFormatter.convertingFullDate(timeInterval: date)
        imageView.kf.setImage(with: imageURL)
        temperatureLabel.text = "\(Int(temperature))°"
    }

}

