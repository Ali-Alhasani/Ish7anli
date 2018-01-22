//
//  ActivationViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/17/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class ActivationViewController: UIViewController {

    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var activationText: UITextField!
    var activationCode:String?
    var phoneNumber:String?
    override func viewDidLoad() {
        super.viewDidLoad()
      self.activationText.text = activationCode!
      self.phoneNumberLabel.text = phoneNumber!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeMobileNumber(_ sender: Any) {
        
    }
    
    @IBAction func resendActivationCode(_ sender: Any) {
        DataClient.shared.logIn(phone: phoneNumber!, success: { (_ activationCode) in
            self.activationCode = String(activationCode)
           

        }) { (_ error) in
            print(error)
        }    }
    
    @IBAction func activateButtonAction(_ sender: Any) {
        DataClient.shared.activate(success: {
            SessionManager.loadSessionManager()

        }, failuer: { (_ error) in
            
        }, activiationCode: activationText.text!)
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
