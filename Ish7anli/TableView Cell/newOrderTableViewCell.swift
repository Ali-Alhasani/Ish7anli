//
//  newOrderTableViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/16/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
protocol newOrderTableViewDelegate : class {
    func didPressFinishedDetailsButton(sender: UIButton)
}

struct newOrderTableViewData {
    
    init(price: Double, image:String,name:String,senderCity:String,receiverCity:String) {
        self.price = price
        self.senderCity = senderCity
        self.image = image
        self.name = name
        self.receiverCity = receiverCity
        

    }
    var price: Double
    var image:String
 
    var name:String
    var senderCity:String
    var receiverCity:String
}
class newOrderTableViewCell: UITableViewCell {
    weak var cellDelegate: newOrderTableViewDelegate?
    
    @IBOutlet weak var ProfileimageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var senderCityLabel: UILabel!
    @IBOutlet weak var receiverCityLabel: UILabel!
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
        if let data = data as? newOrderTableViewData {
            
            self.priceLabel.text = String(data.price)
            self.senderCityLabel.text = data.senderCity
            APIClient.sendImageRequest(path: data.image, success: { (_ image) in
                self.ProfileimageView.image = image
            }, failure: { (_ error) in
                
            })
            self.nameLabel.text = data.name
            self.receiverCityLabel.text = data.receiverCity
        }
    }
    
}
