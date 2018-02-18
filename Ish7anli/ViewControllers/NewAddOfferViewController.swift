//
//  NewAddOfferViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/11/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class NewAddOfferViewController: UIViewController {
    
    
    @IBOutlet weak var senderAddressLabel: UILabel!
    @IBOutlet weak var recevierAddressLabel: UILabel!
    @IBOutlet weak var mobileText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var senderView: UIView!
    @IBOutlet weak var reciverView: UIView!
    var senderTitle:String?
    var recevierTitle:String?
    var senderDetails:String?
    var recevierDetails:String?
    var senderId:Int?
    var recevierId:Int?
    
    var senderLat:Double?
    var senderLng:Double?
    var recevierLat:Double?
    var recevierLng:Double?
    var captainOfferId:Int?
    var indexPath:Int?
    var captainAccountNumber:String?
    var price:String?
    var type:Int?
    @IBOutlet var weightButton: [RadioButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        weightButton[0].isSelected = true
        weightButton[0].alternateButton =   [weightButton[1]]
        weightButton[1].alternateButton =   [weightButton[0]]
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(gesture:)))
        
        let tap2Gesture = UITapGestureRecognizer(target: self, action: #selector(self.view2Tapped(gesture:)))
        if type == 2 {
            senderLat = DataClient.shared.offerPrice[indexPath!].addressSenderLatitude!
            senderLng = DataClient.shared.offerPrice[indexPath!].addressSenderLongitude!
            recevierLat = DataClient.shared.offerPrice[indexPath!].addressReceiverLatitude!
            recevierLng =  DataClient.shared.offerPrice[indexPath!].addressReceiverLongitude!
            senderId =  DataClient.shared.offerPrice[indexPath!].senderAddressId!
            recevierId =  DataClient.shared.offerPrice[indexPath!].receiverAddressId!
            senderTitle =  DataClient.shared.offerPrice[indexPath!].addressSenderTitle!
            recevierTitle =  DataClient.shared.offerPrice[indexPath!].addressReceiverTitle!
            captainAccountNumber = DataClient.shared.offerPrice[indexPath!].captainAccountNumber!
            price = DataClient.shared.offerPrice[indexPath!].price!
            senderDetails = DataClient.shared.offerPrice[indexPath!].addressSenderDetails
            recevierDetails = DataClient.shared.offerPrice[indexPath!].addressReceiverDetails
        }else{
            senderLat =  DataClient.shared.offer[indexPath!].addressSenderLatitude!
            senderLng = DataClient.shared.offer[indexPath!].addressSenderLongitude!
            recevierLat = DataClient.shared.offer[indexPath!].addressReceiverLatitude!
            recevierLng = DataClient.shared.offer[indexPath!].addressReceiverLongitude!
            senderId =  DataClient.shared.offer[indexPath!].senderAddressId!
            recevierId =  DataClient.shared.offer[indexPath!].receiverAddressId!
            senderTitle =  DataClient.shared.offer[indexPath!].addressSenderTitle!
            recevierTitle =  DataClient.shared.offer[indexPath!].addressReceiverTitle!
            senderDetails = DataClient.shared.offer[indexPath!].addressSenderDetails
            recevierDetails = DataClient.shared.offer[indexPath!].addressReceiverDetails
                
            captainAccountNumber = DataClient.shared.offer[indexPath!].captainAccountNumber!
            price = DataClient.shared.offer[indexPath!].price!
            
        }
        
        senderAddressLabel.text = senderTitle
        recevierAddressLabel.text = recevierTitle
        // add it to the image view;
        senderView.addGestureRecognizer(tapGesture)
        reciverView.addGestureRecognizer(tap2Gesture)
        // make sure imageView can be interacted with by user
        senderView.isUserInteractionEnabled = true
        reciverView.isUserInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func viewTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view) != nil {
            self.performSegue(withIdentifier: "toOfferSenderAddress", sender: self)
            //Here you can initiate your new ViewController
            
        }
    }
    
    @objc func view2Tapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view) != nil {
            self.performSegue(withIdentifier: "toOfferReciverAddress", sender: self)
            //Here you can initiate your new ViewController
            
        }
    }
    
    
    
    
    
    @IBAction func orderAction(_ sender: Any) {
        if (mobileText.text!.isEmpty || nameText.text!.isEmpty) {
            var error:String?
            if MOLHLanguage.isRTL() {
                error =  "يجب أن تقوم بإدخال كافة الحقول"
                
            }else{
                error = "You should fill all the fields"
            }
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            self.performSegue(withIdentifier: "toPayment", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toOfferSenderAddress" {
            let vc = segue.destination as! CaptainAddressDetailsViewController
            vc.lat = senderLat
            vc.lng = senderLng
            vc.addressName = senderTitle
            vc.addressDetails = senderDetails
        }
        if segue.identifier == "toOfferReciverAddress" {
            let vc = segue.destination as! CaptainAddressDetailsViewController
            vc.lat = recevierLat
            vc.lng = recevierLng
            vc.addressName = recevierTitle
            vc.addressDetails = recevierDetails
        }
        if segue.identifier == "toPayment" {
            let vc = segue.destination as! PaymentMethodViewController
            vc.senderAddress = senderId!
            vc.receiveAddress = recevierId!
            var selectedButton:Int = 0
            for i in weightButton {
                if i.isSelected == true {
                    selectedButton = i.tag
                }
            }
            vc.weghitIndex = selectedButton + 1
            vc.receiverName = nameText.text
            vc.receiverPhone = mobileText.text!
            vc.captainOfferId = captainOfferId!
            vc.accountNumberString = captainAccountNumber
            vc.amountOfMoneyString = price
        }
    }
    
    //
    // self.perfom
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
