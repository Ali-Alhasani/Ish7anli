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
        load()
    }
    
    
    func load(){
        DataClient.shared.logIn(phone: phoneNumberText.text!, success: { (_ activationCode) in
            self.activationCode = activationCode
            self.performSegue(withIdentifier: "toActivation", sender: self)

        }) { (_ error) in
            print(error)
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
