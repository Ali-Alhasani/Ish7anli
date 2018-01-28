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
     var weightArray = ["heavy", "Light"]
    var deliveryArray = ["Form the door to door" , "from caption cite"]
    override func viewDidLoad() {
        super.viewDidLoad()
      sendTimeLabel.text = DataClient.shared.lastOffer[indexPath!].time
         sendDateLabel.text = DataClient.shared.lastOffer[indexPath!].date
        weightLabel.text = weightArray[DataClient.shared.lastOffer[indexPath!].weight! - 1 ]
        deliveryLabel.text = deliveryArray[DataClient.shared.lastOffer[indexPath!].deliveryType! - 2 ]
        
        locationLabel.text = DataClient.shared.lastOffer[indexPath!].addressSenderTitle
        
        receiverNameLabel.text = DataClient.shared.lastOffer[indexPath!].receiverName
        receiverPhoneLabel.text = DataClient.shared.lastOffer[indexPath!].receiverPhone
        receiverAddressLabel.text = DataClient.shared.lastOffer[indexPath!].addressReceiverCity! + " - " + DataClient.shared.lastOffer[indexPath!].addressReceiverDetails! + " - " + DataClient.shared.lastOffer[indexPath!].addressReceiverTitle!

        
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
