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
    
    init(price: Double, image:String,name:String,senderCity:String,receiverCity:String,isNew:Bool) {
        self.price = price
        self.senderCity = senderCity
        self.image = image
        self.name = name
        self.receiverCity = receiverCity
        self.isNew = isNew

    }
    var price: Double
    var image:String
 
    var name:String
    var senderCity:String
    var receiverCity:String
    var isNew:Bool
}
class newOrderTableViewCell: UITableViewCell {
    weak var cellDelegate: newOrderTableViewDelegate?
    
    @IBOutlet weak var ProfileimageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var senderCityLabel: UILabel!
    @IBOutlet weak var receiverCityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!

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
            var stringFinal:String?
            if MOLHLanguage.isRTL() {
                   self.currencyLabel.text = "ريال "
                //let string: NSMutableAttributedString = NSMutableAttributedString(string: "ريال" + String(data.price) )
                //string.setColorForText(textToFind: "ريال", withColor: UIColor.black)
              
            }else {
                 self.currencyLabel.text = " SAR"
                //let string: NSMutableAttributedString = NSMutableAttributedString(string: "SAR" + String(data.price) )
               // string.setColorForText(textToFind: "SAR", withColor: UIColor.black)
            }
            
            if data.isNew {
                 self.currencyLabel.text = ""
                 if MOLHLanguage.isRTL() {
                    self.priceLabel.text = "جديد"
                    self.priceLabel.textColor = UIColor.green
                 }else{
                     self.priceLabel.text = "New"
                }
            }else {
                self.priceLabel.text  = String(data.price)
            }
            
            
        
            
           
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
