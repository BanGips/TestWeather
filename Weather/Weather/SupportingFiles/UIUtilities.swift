//
//  UIUtilities.swift
//  Weather2
//
//  Created by BanGips on 9/15/20.
//  Copyright © 2020 BanGips. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func applyCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func applyShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 20, height: 20)
        self.layer.shadowOpacity = 0.5
    }
    
}
