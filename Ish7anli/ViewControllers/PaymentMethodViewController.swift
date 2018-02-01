//
//  PaymentMethodViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/17/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class PaymentMethodViewController: UIViewController {
    
    @IBOutlet weak var firstButton: RadioButton!
    @IBOutlet weak var secondButton: RadioButton!
    @IBOutlet weak var thirdButton: RadioButton!
    
    @IBOutlet weak var accountNumber: UITextField!
    @IBOutlet weak var amountOfMoney: UITextField!
    var indexPath:Int?
    
    var senderAddress:Int?
    var receiveAddress:Int?
    var weghitIndex:Int?
    var receiverName:String?
    var receiverPhone:String?
    var type:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        firstButton.alternateButton = [secondButton,thirdButton]
        secondButton.alternateButton = [firstButton,thirdButton]
        thirdButton.alternateButton = [firstButton,secondButton]
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func orderAction(_ sender: Any) {
        var paymentId:Int?
        if firstButton.isSelected {
            paymentId = 1
        }else if secondButton.isSelected {
            paymentId = 2
        }else if thirdButton.isSelected {
            paymentId = 3
        }
        
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        if MOLHLanguage.isRTL() {
            loadingtitle = "جارى الإرسال"
            message = "الرجاء الانتظار"
        }else{
            loadingtitle = "Sending"
            message = "Please Wait"
        }
        spiningActivity.label.text = loadingtitle
        spiningActivity.detailsLabel.text = message
        if (type != nil){
            DataClient.shared.addOffer(addressSenderId: senderAddress! , deliveryType: type!, weight: weghitIndex!, addressReceiverId: receiveAddress!, receiverName: receiverName!, receiverPhone: receiverPhone!, paymentType: paymentId!, success: {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.dismiss(animated: true, completion: nil)
            }) { (_ error) in
                MBProgressHUD.hide(for: self.view, animated: true)
                let alert = UIAlertController(title: alartTitle, message:error.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ok, style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }else {
            DataClient.shared.addOffer(addressSenderId: senderAddress! , deliveryType: 3, weight: weghitIndex!, addressReceiverId: receiveAddress!, receiverName: receiverName!, receiverPhone: receiverPhone!, paymentType: paymentId!, success: {
                MBProgressHUD.hide(for: self.view, animated: true)
            }) { (_ error) in
                MBProgressHUD.hide(for: self.view, animated: true)
                let alert = UIAlertController(title: alartTitle, message:error.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ok, style: .default, handler: nil))
                self.present(alert, animated: true)
            }
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
