//
//  AutoSizeTextField.swift
//  ttttttt
//
//  Created by Ali Al-Hassany on 5/7/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation
import UIKit


class AutoSizeTextField: UITextField {
    var padding = UIEdgeInsets(top: 0, left: 62, bottom: 0, right: 5);

   
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
       
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if MOLHLanguage.isRTL() {
            padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 62);
        }
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
       
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
}    
