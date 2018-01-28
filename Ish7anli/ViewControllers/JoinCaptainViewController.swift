//
//  JoinCaptainViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/26/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class JoinCaptainViewController: UIViewController {

    @IBOutlet weak var fullNameText: UITextField!
    @IBOutlet weak var cardNumberText: UITextField!
    @IBOutlet weak var mobileNumberText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameText.setBottomBorder()
        cardNumberText.setBottomBorder()
        mobileNumberText.setBottomBorder()
        emailText.setBottomBorder()
        passwordText.setBottomBorder()
        confirmPasswordText.setBottomBorder()

//          fullNameText.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//          fullNameText.layer.shadowOpacity = 1.0
//          fullNameText.layer.shadowRadius = 0.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueAction(_ sender: Any) {
        self.performSegue(withIdentifier: "continue", sender: self)
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
