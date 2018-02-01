//
//  CaptainOfferDetailsViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/28/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CaptainOfferDetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var starsView: CosmosView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var destinationCity: UILabel!
    @IBOutlet weak var fromCity: UILabel!
    @IBOutlet weak var timeFrom: UILabel!
    @IBOutlet weak var timeTo: UILabel!
    @IBOutlet weak var dateFrom: UILabel!
    @IBOutlet weak var dateTo: UILabel!
    @IBOutlet weak var price: UILabel!
    var indexPath:Int?
    
    @IBOutlet weak var arrowImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if !MOLHLanguage.isRTL(){
            arrowImage.image = UIImage(named: "backBlueLeft")
        }
        if indexPath != nil {
            nameLabel.text = DataClient.shared.captianOffer[indexPath!].captainName
            starsView.rating = DataClient.shared.captianOffer[indexPath!].captainRate!
            destinationCity.text =  DataClient.shared.captianOffer[indexPath!].cityNameTo
            fromCity.text =  DataClient.shared.captianOffer[indexPath!].cityNameFrom
            timeFrom.text = DataClient.shared.captianOffer[indexPath!].goTime
            timeTo.text =  DataClient.shared.captianOffer[indexPath!].arrivalTime
            dateFrom.text = DataClient.shared.captianOffer[indexPath!].goDate
            dateTo.text = DataClient.shared.captianOffer[indexPath!].arrivalDate
            price.text = DataClient.shared.captianOffer[indexPath!].price! + " SAR"
            
            APIClient.sendImageRequest(path: DataClient.shared.captianOffer[indexPath!].captainImage!, success: { (_ image) in
                self.imageView.image = image
            }, failure: { (_ error) in
                
            })
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseAction(_ sender: Any) {
        //self.performSegue(withIdentifier: "toAddOffer", sender: self)
    }
    
    @IBAction func chatAction(_ sender: Any) {
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
