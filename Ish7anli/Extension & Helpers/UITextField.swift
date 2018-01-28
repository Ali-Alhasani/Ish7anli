//
//  UITextField.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/26/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation

extension UITextField {
    func setBottomBorder() {
       
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowPath = CGPath(rect: CGRect(x: 0, y:  self.frame.height, width: self.frame.width, height: 1), transform: nil)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
       // self.layer.clipsToBounds = true
        self.layer.shadowRadius = 0.0
        
    }
}
