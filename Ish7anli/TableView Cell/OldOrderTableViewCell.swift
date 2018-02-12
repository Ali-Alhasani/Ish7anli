//
//  OldOrderTableViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/11/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
protocol OldOrderTableViewDelegate : class {
    func didPressNonFinishedDetailsButton(sender: UIButton)
    func didPressChatButton(sender:UIButton)
}
struct OldOrderTableViewData {
    
    init(price: Double, image:String,name:String,time:String,date:String,stars: Double,cityFrom:String,cityTo:String ) {
        self.price = price
        self.stars = stars
        self.image = image
        self.name = name
        self.time = time
        self.date = date
        self.cityFrom = cityFrom
        self.cityTo = cityTo
    }
    var price: Double
    var stars: Double
    var image:String
    var name:String
    var time:String
    var date:String
    var cityFrom:String
    var cityTo:String
}
class OldOrderTableViewCell: UITableViewCell {
    weak var cellDelegate: OldOrderTableViewDelegate?

    @IBOutlet weak var ProfileimageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var firstPoint: UIView!
    @IBOutlet weak var secondPoint: UIView!
    @IBOutlet weak var thirdPoint: UIView!
    
    @IBOutlet weak var senderCityLabel: UILabel!
    @IBOutlet weak var middlePointLabel: UILabel!
    @IBOutlet weak var LastCityLabel: UILabel!
    
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
        if let data = data as? OldOrderTableViewData {
            
            self.priceLabel.text = String(data.price)
            self.ratingView.rating = data.stars
            APIClient.sendImageRequest(path: data.image, success: { (_ image) in
                self.ProfileimageView.image = image
            }, failure: { (_ error) in
                
            })
            self.nameLabel.text = data.name
            self.dateLabel.text = data.date + " - " + data.time
            self.senderCityLabel.text = data.cityFrom
            self.LastCityLabel.text = data.cityTo
      
            if MOLHLanguage.isRTL() {
                detailsButton.setTitle(" تفاصيل ", for: .normal)
                chatButton.setTitle(" محادثة ", for: .normal)
                currencyLabel.text = "ريال"
                   self.middlePointLabel.text = "في الطريق"
            }else{
                self.middlePointLabel.text = "in the Way"
            }
        }
    }
    @IBAction func detailsAction(_ sender: Any) {
        cellDelegate?.didPressNonFinishedDetailsButton(sender: sender as! UIButton)
    }
    
    @IBAction func chatAction(_ sender: Any) {
        cellDelegate?.didPressChatButton(sender: sender as! UIButton)
    }
}
