//
//  RadioButton.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/19/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation

import UIKit

class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?
    let checkedImage = UIImage(named: "checkCombo")! as UIImage
    let uncheckedImage = UIImage(named: "unCheckCombo")! as UIImage
    
    override func awakeFromNib() {
      //self.isSelected = false
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setImage(checkedImage, for: UIControlState.normal)

            } else {
                self.setImage(uncheckedImage, for: UIControlState.normal)
            }
        }
    }
}
