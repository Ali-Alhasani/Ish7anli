//
//  CaptainTypeCollectionViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/30/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
protocol CaptainTypeCollectionViewDelegate : class {
    func didPressChoose(sender: UIButton)
   
}

struct CaptainTypeCollectionViewData {
    
    init(type: String, image:String,description:String,image1:String ,image2:String,image3:String ) {
        self.type = type
        self.description = description
        self.image = image
        self.image1 = image1
        self.image2 = image2
        self.image3 = image3
    }
    var type: String
    var description: String
    var image:String
     var image1:String
     var image2:String
     var image3:String
  
}
class CaptainTypeCollectionViewCell: UICollectionViewCell {
 weak var cellDelegate: CaptainTypeCollectionViewDelegate?
    @IBOutlet weak var imageViewType: UIImageView!
    @IBOutlet weak var typeNameLabel: UILabel!
    @IBOutlet weak var typeDescription: UILabel!
    
   
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(_ data: Any?) {
        if let data = data as? CaptainTypeCollectionViewData {
            
            self.typeNameLabel.text = data.type
             self.typeDescription.text = data.description

            
        }
    }
    
    
    
    @IBAction func chooseImage1Action(_ sender: Any) {
        cellDelegate?.didPressChoose(sender: sender as! UIButton)
    }
    
    
    
   
}
