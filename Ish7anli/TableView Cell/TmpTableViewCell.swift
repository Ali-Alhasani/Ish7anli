//
//  TmpTableViewCell.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/10/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
protocol TmpTableViewCellDelegate : class {
    func didPressChoose(sender: UIButton)
    func didPressChat(sender: UIButton)
}

struct TmpTableViewCellData {
    
    init(price: String, image:String,name:String,stars: Double , type :String) {
        self.price = price
        self.stars = stars
        self.image = image
        self.name = name
        self.type = type
     
    }
    var price: String
    var stars: Double
    var image:String
    var name:String
    var type:String
   
}
class TmpTableViewCell: UITableViewCell {
    weak var cellDelegate: TmpTableViewCellDelegate?
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var captionNameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func chooseAction(_ sender: Any) {
        cellDelegate?.didPressChoose(sender: sender as! UIButton)
    }
    @IBAction func chatAction(_ sender: Any) {
        cellDelegate?.didPressChat(sender: sender as! UIButton)
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
            if MOLHLanguage.isRTL() {
                chooseButton.setTitle(" اختيار ", for: .normal)
                 chatButton.setTitle(" محادثة ", for: .normal)
                currencyLabel.text = "ريال"
                cellImage.image = UIImage(named:"cell Right")
            }
            
            if data.type == "1" {
                profileImageView.borderColor = UIColor.yellow
            }else if data.type == "2" {
                  profileImageView.borderColor = UIColor.red
            }else if data.type == "3" {
                   profileImageView.borderColor = UIColor.green
            }
        }
    }


}
