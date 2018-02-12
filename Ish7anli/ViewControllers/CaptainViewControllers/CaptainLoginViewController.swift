//
//  CaptainLoginViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/16/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CaptainLoginViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    


    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !MOLHLanguage.isRTL() {
            backButton.image = UIImage(named: "leftback")
        }

       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       self.navigationController?.navigationBar.shadowImage = UIImage()
     self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
       // passwordText.setBottomBorder()
//        if MOLHLanguage.isRTL() {
//             backButton.setBackgroundImage(UIImage(named: "backNav"), for: UIControlState.normal)
//        }else {
//       backButton.setBackgroundImage(UIImage(named: "leftback"), for: UIControlState.normal)
//
//        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideBackButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
    
        if (passwordText.text!.isEmpty) {
            var error:String?
            if MOLHLanguage.isRTL() {
                error = "يجب أن تقوم بإدخال كلمة المرور"
                
            }else{
                error = "You should enter a valid password"
                
            }
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }else {
        DataClient.shared.loginCaptain(password:  passwordText.text!, success: {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.move()
        }) { (_ error ,_ userStatus)  in
           // print(error.message)
            if (userStatus == "1"){
                self.performSegue(withIdentifier: "untilReview", sender: self)
            }else if (userStatus == "2"){
                  self.performSegue(withIdentifier: "toActivation", sender: self)
            }else if (userStatus == "3"){
                
            }else if (userStatus == "4"){
                  self.performSegue(withIdentifier: "reject", sender: self)
            }else if (userStatus == "5"){
                  self.performSegue(withIdentifier: "reject", sender: self)
            }else {
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:  ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
            }
            
           //print()
        }
        }
   
    }
    
    @IBAction func unwindFromAddVC21(_ sender: UIStoryboardSegue){
        
    }
    
    @IBAction func forgetAction(_ sender: Any) {
        
    }
    
    @IBAction func newAccountAction(_ sender: Any) {
        
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
