//
//  ActiveOrderTableViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/16/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
protocol ActiveOrderTableViewDelegate2 : class {
    func didPressNonFinishedDetailsButton(sender: UIButton)
}

class ActiveOrderTableViewCell2: UITableViewCell {
    weak var cellDelegate: ActiveOrderTableViewDelegate2?
    @IBOutlet weak var ProfileimageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var firstPoint: UIView!
    @IBOutlet weak var secondPoint: UIView!
    @IBOutlet weak var thirdPoint: UIView!
    
    @IBOutlet weak var senderCityLabel: UILabel!
    @IBOutlet weak var middlePointLabel: UILabel!
    @IBOutlet weak var LastCityLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    
//    var isChecked: Bool = false {
//        didSet{
//            if isChecked == true {
//               actionButton.backgroundColor = UIColor.blue
//            } else {
//              actionButton.backgroundColor = UIColor.black
//            }
//        }
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
           //self.isChecked = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

    func setData(_ data: Any?) {
        if let data = data as? ActiveOrderTableViewData {
            
            self.priceLabel.text = String(data.price)
            APIClient.sendImageRequest(path: data.image, success: { (_ image) in
                self.ProfileimageView.image = image
            }, failure: { (_ error) in
                
            })
            self.nameLabel.text = data.name
            self.senderCityLabel.text = data.cityFrom
            self.LastCityLabel.text = data.cityTo
            if MOLHLanguage.isRTL() {
                self.currencyLabel.text = "ريال"
                self.middlePointLabel.text = "في الطريق"
                
            }else {
                self.middlePointLabel.text = "in the Way"
            }
    
            
//            if data.type == 2 {
//                self.actionButton.backgroundColor = UIColor.red
//            }
            
        }
    }
    
    @IBAction func buttonAction(_ sender: Any) { cellDelegate?.didPressNonFinishedDetailsButton(sender: sender as! UIButton)
    }
}
