//
//  TmpTableViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/10/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
protocol MessageTableViewCellDelegate : class {
    func didPressCell(sender: UIButton)
}

struct TmpTableViewCellData {
    
    init(price: Int, image:String,name:String,stars: Double) {
        self.price = price
        self.stars = stars
        self.image = image
        self.name = name
     
    }
    var price: Int
    var stars: Double
    var image:String
    var name:String
   
}
class TmpTableViewCell: UITableViewCell {
    weak var cellDelegate: MessageTableViewCellDelegate?
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var captionNameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setData(_ data: Any?) {
        if let data = data as? TmpTableViewCellData {
            
            self.priceLabel.text = String(data.price)
            self.ratingView.rating = data.stars
            APIClient.sendImageRequest(path: data.image, success: { (_ image) in
                self.profileImageView.image = image
            }, failure: { (_ error) in
                
            })
        
            self.captionNameLabel.text = data.name
        
        }
    }


}
