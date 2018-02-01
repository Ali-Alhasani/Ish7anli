//
//  NewOrderCollectionViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/16/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
struct NewOrderCollectionViewData {
    
    init(price: String, image:String,name:String,time:String,day:String,date:String,cityFrom:String,cityTo:String,stars: Double) {
        self.price = price
        self.stars = stars
        self.image = image
        self.name = name
        self.time = time
        self.day = day
        self.date = date
        self.cityFrom = cityFrom
        self.cityTo = cityTo
    }
    var price: String
    var stars: Double
    var image:String
    var name:String
    var time:String
    var day:String
    var date:String
    var cityFrom:String
    var cityTo:String
}
class NewOrderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var cityFromLabel: UILabel!
    @IBOutlet weak var cityToLabel: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!

    
    func setData(_ data: Any?) {
        if let data = data as? NewOrderCollectionViewData {
            if !MOLHLanguage.isRTL(){
                arrowImage.image = UIImage(named: "backBlueLeft")
            }
            
            self.priceLabel.text = data.price
            self.rateView.rating = data.stars
            APIClient.sendImageRequest(path: data.image, success: { (_ image) in
                 self.imageView.image = image
            }, failure: { (_ error) in

            })
            self.nameLabel.text = data.name
            self.timeLabel.text = data.time
            self.dayLabel.text = data.day
            self.dateLabel.text = data.date
            self.cityFromLabel.text = data.cityFrom
            self.cityToLabel.text = data.cityTo
        }
    }
   
    
    
}