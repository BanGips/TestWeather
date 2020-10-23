//
//  ErrorAlert.swift
//  Weather
//
//  Created by Sergey Kast on 10/23/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert() {
        let alert = UIAlertController(title: "Network error", message: "Not network connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
