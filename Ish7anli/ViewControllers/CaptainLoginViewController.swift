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
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.setBottomBorder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        DataClient.shared.loginCaptain(password:  passwordText.text!, success: {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.move()
        }) { (_ error) in
            
        }
   
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
