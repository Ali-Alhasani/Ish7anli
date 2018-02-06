//
//  JoinCaptainViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/26/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
class JoinCaptainViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var fullNameText: UITextField!
    @IBOutlet weak var cardNumberText: UITextField!
    @IBOutlet weak var mobileNumberText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
  
    var statusEmail:Bool = false
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        self.view.backgroundColor = UIColor(rgb: 0xf7f7f7)
        emailText.delegate = self
        passwordText.delegate = self
        confirmPasswordText.delegate = self


//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//      self.navigationController?.navigationBar.shadowImage = UIImage()
//    self.navigationController?.navigationBar.isTranslucent = true
//    navigationController?.navigationBar.backgroundColor = .clear

        
   
//        fullNameText.setBottomBorder()
//        cardNumberText.setBottomBorder()
//        mobileNumberText.setBottomBorder()
//        emailText.setBottomBorder()
//        passwordText.setBottomBorder()
//        confirmPasswordText.setBottomBorder()

//          fullNameText.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//          fullNameText.layer.shadowOpacity = 1.0
//          fullNameText.layer.shadowRadius = 0.0
        // Do any additional setup after loading the view.
    }
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackButton2()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailText:
             statusEmail = isValidEmail(testStr: self.emailText.text!)
            
            if (statusEmail){
                //                    self.clinicEmailError.text = ""
                self.emailText.layer.borderWidth = 0
                
            }else{
                self.emailText.layer.borderWidth = 1
                self.emailText.layer.borderColor = UIColor.red.cgColor
                //                    self.clinicEmailError.text = "Must be a valid email address"
                
            }
           break
        case confirmPasswordText:
              if (passwordText.text! != confirmPasswordText.text!){
                self.confirmPasswordText.layer.borderWidth = 1
                self.confirmPasswordText.layer.borderColor = UIColor.red.cgColor
              }else{
                self.confirmPasswordText.layer.borderWidth = 0

            }
            break
        default:
             print(textField.text)
        }
       
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        if (fullNameText.text!.isEmpty || cardNumberText.text!.isEmpty || mobileNumberText.text!.isEmpty || emailText.text!.isEmpty || passwordText.text!.isEmpty || confirmPasswordText.text!.isEmpty) {
              var error:String?
            if MOLHLanguage.isRTL() {
                error =  "يجب أن تقوم بإدخال كافة الحقول"
            }else{
               error = "You should fill all the fields"
            }
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }else {
        self.performSegue(withIdentifier: "continue", sender: self)
        }
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "continue" {
            let vc = segue.destination as! CompleteJoinCaptainViewController
            vc.fullname = fullNameText.text!
            vc.cardNumber = cardNumberText.text!
            vc.mobile = mobileNumberText.text!
            vc.email = emailText.text!
            vc.password = passwordText.text!
           
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
