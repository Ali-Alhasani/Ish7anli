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
    
    @IBOutlet weak var accountNumberValueLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    var indexPath:Int?
    @IBOutlet weak var arrowImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if !MOLHLanguage.isRTL(){
            arrowImage.image = UIImage(named: "backBlueLeft")
        }
        nameLabel.text = DataClient.shared.captianArchiveOrder[indexPath!].customerName
        phoneNumberLabel.text = DataClient.shared.captianArchiveOrder[indexPath!].customerPhone
        mailLabel.text = DataClient.shared.captianArchiveOrder[indexPath!].customerEmail
        senderCity.text = DataClient.shared.captianArchiveOrder[indexPath!].addressSenderTitle
        recevierCity.text = DataClient.shared.captianArchiveOrder[indexPath!].addressReceiverTitle
        deliveryLabel.text = ErrorHelper.shared.deliveryArray[ DataClient.shared.captianArchiveOrder[indexPath!].deliveryType! - 1 ]
        weightLabel.text = ErrorHelper.shared.weightArray[DataClient.shared.captianArchiveOrder[indexPath!].weight! - 1 ]
        locationLabel.text =  DataClient.shared.captianArchiveOrder[indexPath!].addressSenderTitle
        receiverNameLabel.text = DataClient.shared.captianArchiveOrder[indexPath!].receiverName
        receiverPhoneNumberlabel.text = DataClient.shared.captianArchiveOrder[indexPath!].receiverPhone
        //DataClient.shared.cpatainCustomerOrder[indexPath.row].price!
        //cpatainCustomerOrder
        if MOLHLanguage.isRTL(){
             priceLabel.text = String((DataClient.shared.captianArchiveOrder[indexPath!].offerPrice!)) + " ريال"
        }else{
        priceLabel.text = String((DataClient.shared.captianArchiveOrder[indexPath!].offerPrice!)) + " SAR"
        }
        ratingView.rating = DataClient.shared.captianArchiveOrder[indexPath!].offerRate!
        APIClient.sendImageRequest(path: DataClient.shared.captianArchiveOrder[indexPath!].customerImage!, success: { (_ image) in
            self.imageView.image = image
        }, failure: { (_ error) in
            
        })
        APIClient.sendImageRequest(path: DataClient.shared.captianArchiveOrder[indexPath!].customerImage!, success: { (_ image) in
            self.receiverImageView.image = image
        }, failure: { (_ error) in
            
        })
        
        paymentMethodLabel.text = ErrorHelper.shared.paymentArray[DataClient.shared.captianArchiveOrder[indexPath!].paymentType! - 1 ]
        if DataClient.shared.captianArchiveOrder[indexPath!].paymentType! == 1 || DataClient.shared.captianArchiveOrder[indexPath!].paymentType! == 2
        {
            accountNumberLabel.text = ""
            accountNumberValueLabel.text = ""
            
        }else {
            accountNumberLabel.text = DataClient.shared.captianArchiveOrder[indexPath!].accountNumber
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chatAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toArchiveChat", sender: self)
    }
    
    
    @IBAction func addressAction(_ sender: Any) {
          //self.performSegue(withIdentifier: "toSenderArchive", sender: self)
    }
    
    @IBAction func receiverAddressAction(_ sender: Any) {
         // self.performSegue(withIdentifier: "toReceiverArchive", sender: self)
    }
    
    @IBAction func cancelOrderAction(_ sender: Any) {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSenderArchive" {
            let vc = segue.destination as! CaptainAddressDetailsViewController
            vc.lat = DataClient.shared.captianArchiveOrder[indexPath!].addressSenderLatitude
            vc.lng = DataClient.shared.captianArchiveOrder[indexPath!].addressSenderLongitude
            vc.addressName = DataClient.shared.captianArchiveOrder[indexPath!].addressSenderTitle
            vc.addressDetails = DataClient.shared.captianArchiveOrder[indexPath!].addressSenderDetails
        }
            if segue.identifier == "toReceiverArchive" {
                let vc = segue.destination as! CaptainAddressDetailsViewController
                vc.lat = DataClient.shared.captianArchiveOrder[indexPath!].addressReceiverLatitude
                vc.lng = DataClient.shared.captianArchiveOrder[indexPath!].addressReceiverLongitude
                vc.addressName = DataClient.shared.captianArchiveOrder[indexPath!].addressReceiverTitle
                vc.addressDetails = DataClient.shared.captianArchiveOrder[indexPath!].addressReceiverDetails
            }
        if segue.identifier == "toArchiveChat" {
            let vc = segue.destination as! ChatViewController
            vc.senderType = .C
            
            vc.targetId = String(DataClient.shared.captianArchiveOrder[indexPath!].customerId!)
            
        }
        
        
        
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
