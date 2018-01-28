//
//  ArchiveOrderDetailsViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/28/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CaptainArchiveOrderDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var IdentityLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    
    @IBOutlet weak var senderCity: UILabel!
    @IBOutlet weak var recevierCity: UILabel!
    
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var receiverImageView: UIImageView!
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var receiverPhoneNumberlabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    var indexPath:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = DataClient.shared.captianArchiveOrder[indexPath!].customerName
        IdentityLabel.text = " "
        phoneNumberLabel.text = DataClient.shared.captianArchiveOrder[indexPath!].customerPhone
        mailLabel.text = DataClient.shared.captianArchiveOrder[indexPath!].customerEmail
        senderCity.text = DataClient.shared.captianArchiveOrder[indexPath!].addressSenderCity
        recevierCity.text = DataClient.shared.captianArchiveOrder[indexPath!].addressReceiverCity
        deliveryLabel.text = deliveryArray[ DataClient.shared.captianArchiveOrder[indexPath!].deliveryType! - 1 ]
        weightLabel.text = weightArray[DataClient.shared.captianArchiveOrder[indexPath!].weight! - 1 ]
        locationLabel.text =  DataClient.shared.captianArchiveOrder[indexPath!].addressSenderTitle
        receiverNameLabel.text = DataClient.shared.captianArchiveOrder[indexPath!].receiverName
        receiverPhoneNumberlabel.text = DataClient.shared.captianArchiveOrder[indexPath!].receiverPhone
        //DataClient.shared.cpatainCustomerOrder[indexPath.row].price!
        //cpatainCustomerOrder
        
        priceLabel.text = String((DataClient.shared.captianArchiveOrder[indexPath!].offerPrice!)) + " SAR"
        ratingView.rating = DataClient.shared.captianArchiveOrder[indexPath!].offerRate!
        APIClient.sendImageRequest(path: DataClient.shared.captianArchiveOrder[indexPath!].customerImage!, success: { (_ image) in
            self.imageView.image = image
        }, failure: { (_ error) in
            
        })
        APIClient.sendImageRequest(path: DataClient.shared.captianArchiveOrder[indexPath!].customerImage!, success: { (_ image) in
            self.receiverImageView.image = image
        }, failure: { (_ error) in
            
        })
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chatAction(_ sender: Any) {
    }
    
    
    @IBAction func addressAction(_ sender: Any) {
    }
    
    @IBAction func receiverAddressAction(_ sender: Any) {
        
    }
    
    @IBAction func cancelOrderAction(_ sender: Any) {
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
