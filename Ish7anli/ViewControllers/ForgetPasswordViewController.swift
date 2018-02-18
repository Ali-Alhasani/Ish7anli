//
//  ForgetPasswordViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/13/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var activationCodeText: UITextField!
    @IBOutlet weak var newPasswordText: UITextField!
    @IBOutlet weak var verifyNewPasswordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        phoneNumberLabel.text = SessionManager.shared.phoneNumber
        verifyNewPasswordText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func resendActivationAction(_ sender: Any) {
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
        spiningActivity.label.text = ErrorHelper.shared.loadingtitle
        spiningActivity.detailsLabel.text = ErrorHelper.shared.message
        DataClient.shared.forgetPassword(success: {
            MBProgressHUD.hide(for: self.view, animated: true)
            
            var alartmessage:String?
            if MOLHLanguage.isRTL() {
                alartmessage = "تم الطلب بنجاح"
                
            }else{
                alartmessage = "the request has been done successfully"
                
            }
            let alert = UIAlertController(title:  ErrorHelper.shared.alartTitle, message:alartmessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:  ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }) { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func submitAction(_ sender: Any) {
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
        spiningActivity.label.text = ErrorHelper.shared.loadingtitle
        spiningActivity.detailsLabel.text = ErrorHelper.shared.message
       
        DataClient.shared.restPassword(success: {
            MBProgressHUD.hide(for: self.view, animated: true)
            
            var alartmessage:String?
            if MOLHLanguage.isRTL() {
                alartmessage = "تم تغيير كلمة المرور بنجاح"
                
            }else{
                alartmessage = "the password has been changed successfully"
                
            }
            let alert = UIAlertController(title:  ErrorHelper.shared.alartTitle, message:alartmessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:  ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }, failuer: { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }, oldPassword: newPasswordText.text!, newPassword: verifyNewPasswordText.text!)
    }
      
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        switch textField {
//
//        case verifyNewPasswordText:
//            if (newPasswordText.text! != verifyNewPasswordText.text!){
//                self.verifyNewPasswordText.layer.borderWidth = 1
//                self.verifyNewPasswordText.layer.borderColor = UIColor.red.cgColor
//            }else{
//                self.verifyNewPasswordText.layer.borderWidth = 0
//
//            }
//            break
//        default:
//            print(textField.text)
//        }
//    }
//
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
