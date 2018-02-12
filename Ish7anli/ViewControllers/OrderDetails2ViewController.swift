//
//  OrderDetails2ViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/17/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class OrderDetails2ViewController: UIViewController {
    var indexPath:Int?
    var finished = false
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
    
    @IBOutlet weak var sendTimeLabel: UILabel!
    @IBOutlet weak var sendDateLabel: UILabel!
    @IBOutlet weak var receiveTimeLabel: UILabel!
    @IBOutlet weak var receiveDateLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var receiverInformationLabel: UILabel!
    
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var receiverPhoneLabel: UILabel!
    
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var receiverAddressLabel: UILabel!

    @IBOutlet weak var arrowImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if finished {
            thirdPoint.backgroundColor = UIColor(named: "niceBlue")
        }
        if !MOLHLanguage.isRTL(){
            arrowImage.image = UIImage(named: "backBlueLeft")
        }
     nameLabel.text = DataClient.shared.lastOffer[indexPath!].captainName
        ratingView.rating = DataClient.shared.lastOffer[indexPath!].captainRate!
     priceLabel.text = String((DataClient.shared.lastOffer[indexPath!].offerPrice)!)
     senderCityLabel.text = DataClient.shared.lastOffer[indexPath!].addressSenderCity
     LastCityLabel.text = DataClient.shared.lastOffer[indexPath!].addressReceiverCity
        
        APIClient.sendImageRequest(path: DataClient.shared.lastOffer[indexPath!].captainImage!
, success: { (_ image) in
            self.ProfileimageView.image = image
        }, failure: { (_ error) in
            
        })
      
        sendTimeLabel.text = DataClient.shared.lastOffer[indexPath!].time
        sendDateLabel.text = DataClient.shared.lastOffer[indexPath!].date
        weightLabel.text =  ErrorHelper.shared.weightArray[DataClient.shared.lastOffer[indexPath!].weight! - 1 ]
        deliveryLabel.text = ErrorHelper.shared.deliveryArray[DataClient.shared.lastOffer[indexPath!].deliveryType! - 1 ]
        
        locationLabel.text = DataClient.shared.lastOffer[indexPath!].addressSenderTitle
        
        receiverNameLabel.text = DataClient.shared.lastOffer[indexPath!].receiverName
        receiverPhoneLabel.text = DataClient.shared.lastOffer[indexPath!].receiverPhone
        receiverAddressLabel.text = DataClient.shared.lastOffer[indexPath!].addressReceiverCity! + " - " + DataClient.shared.lastOffer[indexPath!].addressReceiverDetails! + " - " + DataClient.shared.lastOffer[indexPath!].addressReceiverTitle!
        paymentMethodLabel.text = ErrorHelper.shared.paymentArray[DataClient.shared.lastOffer[indexPath!].paymentType! - 1 ]
        accountNumberLabel.text = DataClient.shared.lastOffer[indexPath!].accountNumber
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
