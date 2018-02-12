//
//  OrderDetailsViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/17/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    var indexPath:Int?
    
    @IBOutlet weak var sendTimeLabel: UILabel!
    @IBOutlet weak var sendDateLabel: UILabel!
    @IBOutlet weak var receiveTimeLabel: UILabel!
    @IBOutlet weak var receiveDateLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var receiverInformationLabel: UILabel!
    
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var receiverPhoneLabel: UILabel!
    @IBOutlet weak var receiverAddressLabel: UILabel!
    // var weightArray = ["heavy", "Light"]
   // var deliveryArray = ["door to door" , "from caption cite","Caption to caption"]
    @IBOutlet weak var arrowImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if !MOLHLanguage.isRTL(){
           arrowImage.image = UIImage(named: "backBlueLeft")
        }
        
        if (DataClient.shared.CustomerOrder.count != 0) {
         sendTimeLabel.text = DataClient.shared.CustomerOrder[indexPath!].time!
         sendDateLabel.text = DataClient.shared.CustomerOrder[indexPath!].date!
        weightLabel.text = ErrorHelper.shared.weightArray[DataClient.shared.CustomerOrder[indexPath!].weight! - 1 ]
        deliveryLabel.text = ErrorHelper.shared.deliveryArray[DataClient.shared.CustomerOrder[indexPath!].deliveryType! - 1 ]
        
        locationLabel.text = DataClient.shared.CustomerOrder[indexPath!].addressSenderTitle!
        
        receiverNameLabel.text = DataClient.shared.CustomerOrder[indexPath!].receiverName!
        receiverPhoneLabel.text = DataClient.shared.CustomerOrder[indexPath!].receiverPhone!
        receiverAddressLabel.text = DataClient.shared.CustomerOrder[indexPath!].addressReceiverCity! + " - " + DataClient.shared.CustomerOrder[indexPath!].addressReceiverDetails! + " - " + DataClient.shared.CustomerOrder[indexPath!].addressReceiverTitle!
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
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
