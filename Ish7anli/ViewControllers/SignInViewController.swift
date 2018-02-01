//
//  SignInViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/17/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
class SignInViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberText: UITextField!
    var activationCode:String?
    var ok,error,alartTitle,loadingtitle,message:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sginInAction(_ sender: Any) {
        if (phoneNumberText.text!.isEmpty) {
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
            
            let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
            
            if MOLHLanguage.isRTL() {
                loadingtitle = "جارى الإرسال"
                message = "الرجاء الانتظار"
            }else{
                loadingtitle = "Sending"
                message = "Please Wait"
            }
            spiningActivity.label.text = loadingtitle
            spiningActivity.detailsLabel.text = message
            
            load()
        }
    }
    
    
    func load(){
        DataClient.shared.logIn(phone: phoneNumberText.text!, success: { (_ activationCode) in
            self.activationCode = activationCode
            MBProgressHUD.hide(for: self.view, animated: true)
            self.performSegue(withIdentifier: "toActivation", sender: self)
            
        }) { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title: self.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: self.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toActivation" {
            
            let vc = segue.destination as! ActivationViewController
            vc.activationCode = activationCode!
            vc.phoneNumber = phoneNumberText.text!
        }
    }
    
}
