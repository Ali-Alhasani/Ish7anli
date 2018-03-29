//
//  AddIdentityViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 3/15/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit


protocol OrderViewControllerDelegate: class {
    func doneOrder()
}

class AddIdentityViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var identityLabel: UITextField!
    var orderId:Int?
      weak var delegate2:OrderViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
         identityLabel.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func isIdentity(phone: String) -> Bool {
        
        let PHONE_REGEX = "^[0-9'@s]{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: phone)
        return result
        
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if isIdentity(phone: identityLabel.text!) {
            DataClient.shared.identityCustomer(success: {
                self.someHandler()
            }, failuer: { (_ error) in
                let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
                self.present(alert, animated: true)
            }, identity: identityLabel.text!, orderId: orderId!)
        }else {
            if MOLHLanguage.isRTL() {
                let error =  "رقم الهوية الذي قمت بإدخاله خاطئ الرجاء التأكد أن الرقم يتكون من ١٠ خانات"
                let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
                self.present(alert, animated: true)
            }else {
                let error =  "identity number should be 10 digits"
                let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    
    func someHandler() {
     
        self.dismiss(animated: true, completion:  {
               self.delegate2?.doneOrder()
        })
        
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
