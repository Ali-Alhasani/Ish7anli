//
//  CheckBox.swift
//  Gasil
//
//  Created by Ali Al-Hassany on 1/19/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation
import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "checked")! as UIImage
    let uncheckedImage = UIImage(named: "checkedWhite")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControlState.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControlState.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
