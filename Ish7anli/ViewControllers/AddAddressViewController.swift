//
//  AddAddressViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/17/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class AddAddressViewController: UIViewController {

    @IBOutlet weak var addressNameText: UITextField!
    @IBOutlet weak var addressDetailsText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addAddressAction(_ sender: Any) {
        if ((addressNameText.text?.isEmpty)! || (addressDetailsText.text?.isEmpty)!){
            let alert = UIAlertController(title: "Alert", message:"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
           load()
        }
       
    }
    
    
    func load(){
        DataClient.shared.addAddress(title: addressDetailsText.text!, details: addressDetailsText.text!, longitude: 10, latitude: 10, success: {
            self.dismiss(animated: true, completion: {
                
            })
        }) { (_ error) in
            
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
