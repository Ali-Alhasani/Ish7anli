//
//  ActivationViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/17/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import PopupDialog
class ActivationViewController: UIViewController {

    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var activationText: UITextField!
    
    var activationCode:String?
    var phoneNumber:String?
     var ok,error,alartTitle,loadingtitle,message:String?
    override func viewDidLoad() {
        super.viewDidLoad()
      //self.activationText.text = activationCode!
      self.phoneNumberLabel.text = phoneNumber!
        // Do any additional setup after loading the view.
        if MOLHLanguage.isRTL() {
         
            self.ok = "موافق"
            self.alartTitle = "تنبيه"
        }else{
            self.ok = "Ok"
            self.alartTitle = "Alert"
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeMobileNumber(_ sender: Any) {
        showCustomDialog()
    }
    
    @IBAction func resendActivationCode(_ sender: Any) {
        
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        if MOLHLanguage.isRTL() {
            self.loadingtitle = "جارى الإرسال"
            self.message = "الرجاء الانتظار"
        }else{
            self.loadingtitle = "Sending"
            self.message = "Please Wait"
        }
        spiningActivity.label.text = self.loadingtitle
        spiningActivity.detailsLabel.text = self.message
        
          load()
    }
    
    @IBAction func activateButtonAction(_ sender: Any) {
        
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        if MOLHLanguage.isRTL() {
            self.loadingtitle = "جارى الإرسال"
            self.message = "الرجاء الانتظار"
        }else{
            self.loadingtitle = "Sending"
            self.message = "Please Wait"
        }
        spiningActivity.label.text = self.loadingtitle
        spiningActivity.detailsLabel.text = self.message
        
        DataClient.shared.activate(success: {
            SessionManager.loadSessionManager()
           self.performSegue(withIdentifier: "completeRegistration", sender: self)
     MBProgressHUD.hide(for: self.view, animated: true)
        }, failuer: { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title: self.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: self.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }, activiationCode: activationText.text!)
    }
    
    
    func load(){
        DataClient.shared.logIn(phone: phoneNumber!, success: { (_ activationCode) in
             MBProgressHUD.hide(for: self.view, animated: true)
            //self.activationCode = String(activationCode)
        }) { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title: self.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: self.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    
    
    
    
    func showCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let ratingVC = NewPhoneNumberViewController(nibName: "NewPhoneNumberViewController", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: ratingVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        // Create first button
        let buttonOne = CancelButton(title: "Cancel", height: 60) {
            //self.label.text = "You canceled the rating dialog"
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "Save", height: 60) {
            if (ratingVC.newPhoneNumberText.text!.isEmpty) {
                //var ok,error,title:String?
                if MOLHLanguage.isRTL() {
                    self.error =  "يجب أن تقوم بإدخال رقم الهاتف المحمول"
                    self.ok = "موافق"
                    self.alartTitle = "تنبيه"
                }else{
                    self.error = "You should enter a valid mobile number"
                    self.ok = "Ok"
                    self.alartTitle = "Alert"
                    
                }
                let alert = UIAlertController(title: self.alartTitle, message:self.error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: self.ok, style: .default, handler: nil))
                self.present(alert, animated: true)
            }else {
            
            self.phoneNumber = ratingVC.newPhoneNumberText.text!
                
                let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
                
                if MOLHLanguage.isRTL() {
                    self.loadingtitle = "جارى الإرسال"
                    self.message = "الرجاء الانتظار"
                }else{
                    self.loadingtitle = "Sending"
                    self.message = "Please Wait"
                }
                spiningActivity.label.text = self.loadingtitle
                spiningActivity.detailsLabel.text = self.message
                
                self.load()
            }
           // self.loadRate(rate: ratingVC.cosmosStarRating.rating, captainId: DataClient.shared.lastOffer[indexPath].captainId!, customerOfferId: DataClient.shared.lastOffer[indexPath].customerId!)
            
            //self.label.text = "You rated \(ratingVC.cosmosStarRating.rating) stars"
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: animated, completion: nil)
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
