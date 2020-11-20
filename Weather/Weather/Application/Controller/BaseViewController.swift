//
//  BaseViewController.swift
//  Weather
//
//  Created by BanGips on 10/29/20.
//

import UIKit

class BaseViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem()
    }

}

extension UIViewController {
    func showAlert(description: String) {
        let alert = UIAlertController(title: "Network error", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


