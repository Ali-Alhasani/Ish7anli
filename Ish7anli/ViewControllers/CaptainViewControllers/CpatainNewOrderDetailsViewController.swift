//
//  CpatainNewOrderDetailsViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/28/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import PopupDialog
class CpatainNewOrderDetailsViewController: UIViewController {
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
    
    @IBOutlet weak var accountNumberValueLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    var indexPath:Int?
    var isFiltered:Bool = false
    @IBOutlet weak var arrowImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if !MOLHLanguage.isRTL(){
            arrowImage.image = UIImage(named: "backBlueLeft")
            
        }
        if (isFiltered){
            
            
            nameLabel.text = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].customerName
            phoneNumberLabel.text = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].customerPhone
            mailLabel.text = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].customerEmail
            senderCity.text = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].addressSenderTitle
            recevierCity.text = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].addressReceiverTitle
            
            deliveryLabel.text =  ErrorHelper.shared.deliveryArray[ DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].deliveryType! - 1 ]
            weightLabel.text =  ErrorHelper.shared.weightArray[DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].weight! - 1 ]
            locationLabel.text =  DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].addressSenderTitle
            receiverNameLabel.text = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].receiverName
            receiverPhoneNumberlabel.text = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].receiverPhone
            //DataClient.shared.cpatainCustomerOrder[indexPath.row].price!
            //cpatainCustomerOrder
            
            APIClient.sendImageRequest(path: DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].customerImage!, success: { (_ image) in
                self.imageView.image = image
            }, failure: { (_ error) in
                
            })
            APIClient.sendImageRequest(path: DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].customerImage!, success: { (_ image) in
                self.receiverImageView.image = image
            }, failure: { (_ error) in
                
            })
            
            paymentMethodLabel.text = ErrorHelper.shared.paymentArray[DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].paymentType! - 1 ]
            if DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].paymentType! == 1 || DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].paymentType! == 2
            {
                accountNumberLabel.text = ""
                accountNumberValueLabel.text = ""
                
            }else {
               accountNumberLabel.text = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].accountNumber
                
            }

        }
        else {
            nameLabel.text = DataClient.shared.cpatainCustomerOrder[indexPath!].customerName
            phoneNumberLabel.text = DataClient.shared.cpatainCustomerOrder[indexPath!].customerPhone
            mailLabel.text = DataClient.shared.cpatainCustomerOrder[indexPath!].customerEmail
            senderCity.text = DataClient.shared.cpatainCustomerOrder[indexPath!].addressSenderTitle
            recevierCity.text = DataClient.shared.cpatainCustomerOrder[indexPath!].addressReceiverTitle
            deliveryLabel.text =  ErrorHelper.shared.deliveryArray[ DataClient.shared.cpatainCustomerOrder[indexPath!].deliveryType! - 1 ]
            weightLabel.text =  ErrorHelper.shared.weightArray[DataClient.shared.cpatainCustomerOrder[indexPath!].weight! - 1 ]
            locationLabel.text =  DataClient.shared.cpatainCustomerOrder[indexPath!].addressSenderTitle
            receiverNameLabel.text = DataClient.shared.cpatainCustomerOrder[indexPath!].receiverName
            receiverPhoneNumberlabel.text = DataClient.shared.cpatainCustomerOrder[indexPath!].receiverPhone
            //DataClient.shared.cpatainCustomerOrder[indexPath.row].price!
            //cpatainCustomerOrder
            
            APIClient.sendImageRequest(path: DataClient.shared.cpatainCustomerOrder[indexPath!].customerImage!, success: { (_ image) in
                self.imageView.image = image
            }, failure: { (_ error) in
                
            })
            APIClient.sendImageRequest(path: DataClient.shared.cpatainCustomerOrder[indexPath!].customerImage!, success: { (_ image) in
                self.receiverImageView.image = image
            }, failure: { (_ error) in
                
            })
            
            paymentMethodLabel.text = ErrorHelper.shared.paymentArray[DataClient.shared.cpatainCustomerOrder[indexPath!].paymentType! - 1 ]
            if DataClient.shared.cpatainCustomerOrder[indexPath!].paymentType! == 1 || DataClient.shared.cpatainCustomerOrder[indexPath!].paymentType! == 2
            {
                accountNumberLabel.text = ""
                accountNumberValueLabel.text = ""
                
            }else {
                accountNumberLabel.text = DataClient.shared.cpatainCustomerOrder[indexPath!].accountNumber
                
            }

        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chatAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toNewChat", sender: self)
    }
    
    
    @IBAction func addressAction(_ sender: Any) {
        // self.performSegue(withIdentifier: "toSenderNew", sender: self)
    }
    
    @IBAction func receiverAddressAction(_ sender: Any) {
        //self.performSegue(withIdentifier: "toReceiverNew", sender: self)
    }
    
    @IBAction func addPriceAction(_ sender: Any) {
        customerOfferId = DataClient.shared.cpatainCustomerOrder[indexPath!].id!
        
        showCustomDialog()
    }
    func showCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let ratingVC = AddPriceViewController(nibName: "AddPriceViewController", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: ratingVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        // Add buttons to dialog
        //popup.addButtons([buttonOne, buttonTwo])
        //viewModel.addSlientData()
        // Present dialog
        present(popup, animated: animated, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSenderNew" {
            let vc = segue.destination as! CaptainAddressDetailsViewController
            if (isFiltered){
                
                
                vc.lat = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].addressSenderLatitude
                vc.lng = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].addressSenderLongitude
                vc.addressName = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].addressSenderTitle
                vc.addressDetails = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].addressSenderDetails
            } else {
                vc.lat = DataClient.shared.cpatainCustomerOrder[indexPath!].addressSenderLatitude
                vc.lng = DataClient.shared.cpatainCustomerOrder[indexPath!].addressSenderLongitude
                vc.addressName = DataClient.shared.cpatainCustomerOrder[indexPath!].addressSenderTitle
                vc.addressDetails = DataClient.shared.cpatainCustomerOrder[indexPath!].addressSenderDetails
            }
        }
        if segue.identifier == "toReceiverNew" {
            let vc = segue.destination as! CaptainAddressDetailsViewController
            if (isFiltered){
                vc.lat = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].addressReceiverLatitude
                vc.lng = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].addressReceiverLongitude
                vc.addressName = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].addressReceiverTitle
                vc.addressDetails = DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].addressReceiverDetails
            }else {
                vc.lat = DataClient.shared.cpatainCustomerOrder[indexPath!].addressReceiverLatitude
                vc.lng = DataClient.shared.cpatainCustomerOrder[indexPath!].addressReceiverLongitude
                vc.addressName = DataClient.shared.cpatainCustomerOrder[indexPath!].addressReceiverTitle
                vc.addressDetails = DataClient.shared.cpatainCustomerOrder[indexPath!].addressReceiverDetails
            }
            
        }
        if segue.identifier == "toNewChat" {
            let vc = segue.destination as! ChatViewController
            vc.senderType = .C
            if (isFiltered){
                vc.targetId = String(DataClient.shared.cpatainCustomerOrderFiltered[indexPath!].customerId!)
            }else{
                vc.targetId = String(DataClient.shared.cpatainCustomerOrder[indexPath!].customerId!)
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
