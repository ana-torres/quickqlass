//
//  Utilities.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 11/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import UIKit
import Foundation

extension UITextField {
    
    func mainField() {
        
        self.borderStyle = .none
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor //(red: 0.667, green: 0.667, blue: 0.667, alpha: 1).cgColor
        border.frame = CGRect (x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
}

extension UIButton {
    
    func mainButton() {
        
        self.layer.cornerRadius = self.frame.size.height/2
        self.backgroundColor = UIColor(red:0.31, green:0.80, blue:0.66, alpha:1.0)
        self.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
    }
    
    func secButton() {
        
        self.setTitleColor(UIColor(red:0.31, green:0.80, blue:0.66, alpha:1.0), for: UIControl.State.normal)
        self.setTitleColor(UIColor.blue, for: UIControl.State.highlighted)
    }
}

extension UILabel {
    
    func fieldLabel() {
        
        self.textColor = UIColor(red:0.31, green:0.80, blue:0.66, alpha:1.0) //(red: 0.667, green: 0.667, blue: 0.667, alpha: 1)
        self.font = self.font.withSize(15)        
    }
    
    func mainLabel() {
        
        self.textColor = UIColor(red:0.31, green:0.80, blue:0.66, alpha:1.0)
        self.font = self.font.withSize(40)
    }
}


