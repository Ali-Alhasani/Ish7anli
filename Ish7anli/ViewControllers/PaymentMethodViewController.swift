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
    
    var senderAddress:String?
    var receiveAddress:String?
    var weghitIndex:Int?
    
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
        DataClient.shared.addOffer(addressSenderId: Int(senderAddress!)! , deliveryType: 3, weight: weghitIndex!, addressReceiverId: Int(receiveAddress!)!, receiverName: "receiveAddress", receiverPhone: "String", paymentType: paymentId!, success: {
            print("Fuck you, you did it!")
        }) { (_ error) in
            print(error)
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
