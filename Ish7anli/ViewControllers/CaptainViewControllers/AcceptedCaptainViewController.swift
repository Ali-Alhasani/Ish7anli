//
//  AcceptedCaptainViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/7/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class AcceptedCaptainViewController: UIViewController {

    @IBOutlet weak var verificationCodeText: UITextField!
    var activationCodeC:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
     // verificationCodeText.text = activationCodeC!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginAction(_ sender: Any) {
        if ( verificationCodeText.text?.isEmpty)! {
            var error:String?
            if MOLHLanguage.isRTL() {
                error = "يجب أن تقوم بإدخال كود التفعيل"
                
            }else{
                error = "You should enter a valid activation code"
                
            }
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
            
            
            spiningActivity.label.text = ErrorHelper.shared.loadingtitle
            spiningActivity.detailsLabel.text = ErrorHelper.shared.message
         load()
        }
       
    }
    
    
    func load(){
        DataClient.shared.activateCaptain(success: {
              MBProgressHUD.hide(for: self.view, animated: true)
            self.performSegue(withIdentifier: "toLogin", sender: self)
          

        }, failuer: { (_ error) in
              MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }, activiationCode:  verificationCodeText.text!)
      
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
