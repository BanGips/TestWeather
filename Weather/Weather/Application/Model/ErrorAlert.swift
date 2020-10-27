//
//  ErrorAlert.swift
//  Weather
//
//  Created by Sergey Kast on 10/23/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(description: String) {
        let alert = UIAlertController(title: "Network error", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

