//
//  CaptainNewOrderDetailsViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/28/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CaptainActiveOrderDetailsViewController: UIViewController {
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
    
    
    @IBOutlet weak var priceLabel: UILabel!
    var indexPath:Int?
    var ok,error,alartTitle,loadingtitle,message:String?

    @IBOutlet weak var arrowImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if !MOLHLanguage.isRTL(){
            arrowImage.image = UIImage(named: "backBlueLeft")
        }
        
        if (DataClient.shared.cpatainActiveOrder.count != 0) {
        nameLabel.text = DataClient.shared.cpatainActiveOrder[indexPath!].customerName
        IdentityLabel.text = " "
        phoneNumberLabel.text = DataClient.shared.cpatainActiveOrder[indexPath!].customerPhone
        mailLabel.text = DataClient.shared.cpatainActiveOrder[indexPath!].customerEmail
        senderCity.text = DataClient.shared.cpatainActiveOrder[indexPath!].addressSenderCity
        recevierCity.text = DataClient.shared.cpatainActiveOrder[indexPath!].addressReceiverCity
        deliveryLabel.text = deliveryArray[ DataClient.shared.cpatainActiveOrder[indexPath!].deliveryType! - 1 ]
        weightLabel.text = weightArray[DataClient.shared.cpatainActiveOrder[indexPath!].weight! - 1 ]
        locationLabel.text =  DataClient.shared.cpatainActiveOrder[indexPath!].addressSenderTitle
        receiverNameLabel.text = DataClient.shared.cpatainActiveOrder[indexPath!].receiverName
        receiverPhoneNumberlabel.text = DataClient.shared.cpatainActiveOrder[indexPath!].receiverPhone
        //DataClient.shared.cpatainCustomerOrder[indexPath.row].price!
        //cpatainCustomerOrder
        priceLabel.text = String(DataClient.shared.cpatainActiveOrder[indexPath!].price!) + " SAR"
        APIClient.sendImageRequest(path: DataClient.shared.cpatainActiveOrder[indexPath!].customerImage!, success: { (_ image) in
            self.imageView.image = image
        }, failure: { (_ error) in
            
        })
        APIClient.sendImageRequest(path: DataClient.shared.cpatainActiveOrder[indexPath!].customerImage!, success: { (_ image) in
            self.receiverImageView.image = image
        }, failure: { (_ error) in
            
        })
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chatAction(_ sender: Any) {
    }
    
    
    @IBAction func addressAction(_ sender: Any) {
          self.performSegue(withIdentifier: "toSenderActive", sender: self)
    }
    
    @IBAction func receiverAddressAction(_ sender: Any) {
          self.performSegue(withIdentifier: "toReceiverActive", sender: self)
        
    }

    @IBAction func cancelOrderAction(_ sender: Any) {
        DataClient.shared.captainCancelOffer(success: {
            
        }, failuer: { (_ error) in
            let alert = UIAlertController(title: self.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: self.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }, customerOfferId: DataClient.shared.cpatainActiveOrder[indexPath!].id!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSenderActive" {
            let vc = segue.destination as! CaptainAddressDetailsViewController
            vc.lat = DataClient.shared.cpatainActiveOrder[indexPath!].addressSenderLatitude
            vc.lng = DataClient.shared.cpatainActiveOrder[indexPath!].addressSenderLongitude
            vc.addressName = DataClient.shared.cpatainActiveOrder[indexPath!].addressSenderTitle
            vc.addressDetails = DataClient.shared.cpatainActiveOrder[indexPath!].addressSenderDetails
            
            if segue.identifier == "toReceiverActive" {
                let vc = segue.destination as! CaptainAddressDetailsViewController
                vc.lat = DataClient.shared.cpatainActiveOrder[indexPath!].addressReceiverLatitude
                vc.lng = DataClient.shared.cpatainActiveOrder[indexPath!].addressReceiverLongitude
                vc.addressName = DataClient.shared.cpatainActiveOrder[indexPath!].addressReceiverTitle
                vc.addressDetails = DataClient.shared.cpatainActiveOrder[indexPath!].addressReceiverDetails
            }
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