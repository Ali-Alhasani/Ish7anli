//
//  OldOrderWithRateTableViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/11/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
protocol OldOrderWithRateTableViewDelegate : class {
    func didPressFinishedDetailsButton(sender: UIButton)
    func didPressRateButton(sender: UIButton)
    func didPressChatButton(sender: UIButton)

}

struct OldOrderWithRateTableViewData {
    
    init(price: String, image:String,name:String,time:String,date:String,stars: Double , type:String) {
        self.price = price
        self.stars = stars
        self.image = image
        self.name = name
        self.time = time
        self.date = date
        self.type = type
    }
    var price: String
    var stars: Double
    var image:String
    var name:String
    var time:String
    var date:String
    var type:String
    
}
class OldOrderWithRateTableViewCell: UITableViewCell {
    weak var cellDelegate: OldOrderWithRateTableViewDelegate?

    @IBOutlet weak var ProfileimageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var chatButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ data: Any?) {
        if let data = data as? OldOrderWithRateTableViewData {
            
            self.priceLabel.text = String(data.price)
            self.ratingView.rating = data.stars
            APIClient.sendImageRequest(path: data.image, success: { (_ image) in
                self.ProfileimageView.image = image
            }, failure: { (_ error) in
                
            })
            self.nameLabel.text = data.name
            self.dateLabel.text = data.date + " - " + data.time
            if MOLHLanguage.isRTL() {
                detailsButton.setTitle(" تفاصيل ", for: .normal)
                chatButton.setTitle(" محادثة ", for: .normal)
                currencyLabel.text = "ريال"
                rateButton.setTitle("تقييم الطلب", for: UIControlState.normal)
            }
            if data.type == "1" {
               self.ProfileimageView.borderColor = UIColor.yellow
            }else if data.type == "2"{
                  self.ProfileimageView.borderColor = UIColor.red
            }else if data.type == "3"{
                 self.ProfileimageView.borderColor = UIColor.green
            }
            
        }
    }
    
    @IBAction func rateButtonAction(_ sender: Any) {
        cellDelegate?.didPressRateButton(sender: sender as! UIButton)
    }
    @IBAction func detailsAction(_ sender: Any) {
        cellDelegate?.didPressFinishedDetailsButton(sender: sender as! UIButton)

    }
    @IBAction func chatAction(_ sender: Any) {
        cellDelegate?.didPressChatButton(sender: sender as! UIButton)
    }
    
}
