//
//  AddPriceViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/29/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class AddPriceViewController: UIViewController {

    @IBOutlet weak var priceText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    @IBAction func savePriceAction(_ sender: Any) {
        
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
extension AddPriceViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing()
        return true
    }
}
