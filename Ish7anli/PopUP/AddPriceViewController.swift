//
//  AddPriceViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/29/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
 var customerOfferId:Int?
class AddPriceViewController: UIViewController {
    
    @IBOutlet weak var priceText: UITextField!
   
    var error:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        
      
        
        print(customerOfferId!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    @IBAction func savePriceAction(_ sender: Any) {
        if (priceText.text?.isEmpty)! {
            if MOLHLanguage.isRTL() {
                self.error =  "يجب ان تقوم بإدخال سعر"
                
            }else{
                self.error = "You should enter a valid price number"
                
                
            }
            
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:self.error, preferredStyle: .alert)
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
        
        DataClient.shared.captainBidOffer(success: {
              MBProgressHUD.hide(for: self.view, animated: true)
            self.dismiss(animated: true, completion: nil)
        }, failuer: { (_ error) in
              MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }, customerOfferId: customerOfferId!, price: priceText.text!)
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
