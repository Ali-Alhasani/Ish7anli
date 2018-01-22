//
//  ImageHeaderCell.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/3/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

protocol ImageHeaderViewDelegate : class {
    func didPressBackButton(sender: UIButton)
}
class ImageHeaderView : UIView {
    
    @IBOutlet weak var profileImage : UIImageView!
    weak var ImageHeaderView: ImageHeaderViewDelegate?
   
    override func awakeFromNib() {
        super.awakeFromNib()
       // self.backgroundColor = UIColor(hex: "E0E0E0")
//        self.profileImage.layoutIfNeeded()
//        self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
//        self.profileImage.clipsToBounds = true
//        self.profileImage.layer.borderWidth = 1
//        self.profileImage.layer.borderColor = UIColor.white.cgColor
       // self.profileImage.setRandomDownloadImage(80, height: 80)
    }
    

}