//
//  CustomButton.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/29/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 6).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.8, height: 0.8)
            shadowLayer.shadowOpacity = 0.4
            shadowLayer.shadowRadius = 1.5

            
            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
    
}
