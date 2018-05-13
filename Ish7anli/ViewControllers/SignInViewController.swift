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
    var isExist:Bool?
    var isCaptain:Bool?
    weak var delegate: LeftMenuProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.removeNavigationBarItem()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            guard let vc = (self.slideMenuController()?.mainViewController as? UINavigationController)?.topViewController else {
                return
            }
            if vc.isKind(of: SignInViewController.self)  {
                self.slideMenuController()?.removeLeftGestures()
                self.slideMenuController()?.removeRightGestures()
            }
        })
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
            
            if  isValidPhone(phone:  phoneNumberText.text!) {
                let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
                
                
                spiningActivity.label.text = ErrorHelper.shared.loadingtitle
                spiningActivity.detailsLabel.text = ErrorHelper.shared.message
                
                load()
            }else {
                let error =
"الرقم الذي قمت بإدخاله خاطئ ، الرجاء التأكد أن رقم الهاتف يتكون من ١٠ خانات مبدوءً بالمقدمة 05 "
                let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    
    func isValidPhone(phone: String) -> Bool {
        
         let PHONE_REGEX = "^05[0-9'@s]{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: phone)
        return result
        
    }
    
    
    func load(){
        DataClient.shared.logIn(phone: "0966"+phoneNumberText.text!, success: { (_ activationCode , _ isExist , _ isCaptain)  in
            self.activationCode = activationCode
            self.isExist = isExist
            self.isCaptain = isCaptain
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
            vc.isExist = isExist
            vc.isCaptain = isCaptain
        }
    }
    
}
