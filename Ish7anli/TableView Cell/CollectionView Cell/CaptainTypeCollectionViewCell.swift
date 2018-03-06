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

enum color: Int {
    
    case yellow = 0
    case red = 1
    case green = 2
}

struct CaptainTypeCollectionViewData {
    
    init(type: String, image:color,description:String) {
        self.type = type
        self.description = description
        self.image = image
      
    }
    var type: String
    var description: String
    var image:color

  
}
class CaptainTypeCollectionViewCell: UICollectionViewCell {
 weak var cellDelegate: CaptainTypeCollectionViewDelegate?
    @IBOutlet weak var imageViewType: UIImageView!
    @IBOutlet weak var typeNameLabel: UILabel!
    @IBOutlet weak var typeDescription: UILabel!
    @IBOutlet weak var chooseButton: CustomButton2!
    
   
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(_ data: Any?) {
        if let data = data as? CaptainTypeCollectionViewData {
            
            self.typeNameLabel.text = data.type
            self.typeDescription.text = data.description
            switch data.image {
            case .yellow:
                 self.imageViewType.borderColor = UIColor.yellow
            case .red:
                  self.imageViewType.borderColor = UIColor.red
            case .green:
                
                  self.imageViewType.borderColor = UIColor.green
            }
           
          
            
        }
    }
    
    
    
    @IBAction func chooseImage1Action(_ sender: Any) {
        cellDelegate?.didPressChoose(sender: sender as! UIButton)
    }
    
    
    
   
}
