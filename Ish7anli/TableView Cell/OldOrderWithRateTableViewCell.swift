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

}

struct OldOrderWithRateTableViewData {
    
    init(price: Double, image:String,name:String,time:String,date:String,stars: Double) {
        self.price = price
        self.stars = stars
        self.image = image
        self.name = name
        self.time = time
        self.date = date
    }
    var price: Double
    var stars: Double
    var image:String
    var name:String
    var time:String
    var date:String
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
        }
    }
    
    @IBAction func rateButtonAction(_ sender: Any) {
        cellDelegate?.didPressRateButton(sender: sender as! UIButton)
    }
    @IBAction func detailsAction(_ sender: Any) {
        cellDelegate?.didPressFinishedDetailsButton(sender: sender as! UIButton)

    }
    
}
