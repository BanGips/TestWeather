//
//  SavedForecastViewController.swift
//  Weather
//
//  Created by BanGips on 25.11.20.
//

import UIKit

class SavedForecastViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }
    

}

extension SavedForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = "inxer"
        
        return cell
    }
    
    
}
