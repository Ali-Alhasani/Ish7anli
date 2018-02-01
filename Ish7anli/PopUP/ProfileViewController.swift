//
//  ProfileViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/30/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var mobileLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if ( DataClient.shared.profile != nil) {
             nameLabel.text = DataClient.shared.profile?.name
            mobileLabel.text = DataClient.shared.profile?.phone
            emailLabel.text = DataClient.shared.profile?.email
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        view.endEditing(true)
        
        if (!nameLabel.text!.isEmpty || !mobileLabel.text!.isEmpty || !emailLabel.text!.isEmpty){
          load()
        }else {
        
        self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func load(){
        DataClient.shared.saveProfileCustomer(success: {
            print("success")
              self.dismiss(animated: true, completion: nil)
        }, failuer: { (_ error) in
            print(error)
        }, email: emailLabel.text!, name: nameLabel.text!)
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
