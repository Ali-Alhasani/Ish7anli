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
            var error:String?
            if MOLHLanguage.isRTL() {
               error =  "يجب أن تقوم بإدخال رقم الهاتف المحمول"
                
            }else{
                error = "You should enter a valid mobile number"
                
            }
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }else {
            
            let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
            
           
            spiningActivity.label.text = ErrorHelper.shared.loadingtitle
            spiningActivity.detailsLabel.text = ErrorHelper.shared.message
            
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
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
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
