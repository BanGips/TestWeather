//
//  ViewController.swift
//  Weather
//
//  Created by BanGips on 9/21/20.
//

import UIKit

class StartScreenViewController: UIViewController {
    @IBOutlet weak var startScreenTableView: UITableView!
    private let modeSelectionArray = ["Check by geolocation", "Check by name of city", "Check by map"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        startScreenTableView.delegate = self
        startScreenTableView.dataSource = self
        startScreenTableView.register(UINib(nibName: "CustomSSTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "TVCell")

        }
    }

extension StartScreenViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modeSelectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = startScreenTableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath)
        guard let customCell = cell as? CustomSSTableViewCell else { return cell }
        customCell.modeSelectionWeatherLabel.text = modeSelectionArray[indexPath.row]
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let destinationVC = ViewControllerFactory.makeWeatherViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        case 1:
            let destinationVC = ViewControllerFactory.makeCitySelectionViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        case 2:
            let destinationVC = ViewControllerFactory.makeMapViewController()
            navigationController?.pushViewController(destinationVC, animated: true)
        default:
            break
        }
    }
    
}

