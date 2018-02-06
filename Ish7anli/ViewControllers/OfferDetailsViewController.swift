//
//  OfferDetailsViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/17/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class OfferDetailsViewController: UIViewController {
    
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
    var type:Int?
    
    @IBOutlet weak var arrowImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if !MOLHLanguage.isRTL(){
            arrowImage.image = UIImage(named: "backBlueLeft")
        }
        if indexPath != nil {
            nameLabel.text = DataClient.shared.offer[indexPath!].captainName
            starsView.rating = DataClient.shared.offer[indexPath!].captainRate!
            destinationCity.text =  DataClient.shared.offer[indexPath!].cityNameTo
            fromCity.text =  DataClient.shared.offer[indexPath!].cityNameFrom
            timeFrom.text = DataClient.shared.offer[indexPath!].goTime
            timeTo.text =  DataClient.shared.offer[indexPath!].arrivalTime
            dateFrom.text = DataClient.shared.offer[indexPath!].goDate
            dateTo.text = DataClient.shared.offer[indexPath!].arrivalDate
            price.text = DataClient.shared.offer[indexPath!].price! + " SAR"
            
            APIClient.sendImageRequest(path: DataClient.shared.offer[indexPath!].captainImage!, success: { (_ image) in
                self.imageView.image = image
            }, failure: { (_ error) in
                
            })
        }
        if (type == 2) {
            nameLabel.text = DataClient.shared.offerPrice[indexPath!].captainName
            starsView.rating = DataClient.shared.offerPrice[indexPath!].captainRate!
            destinationCity.text =  DataClient.shared.offerPrice[indexPath!].cityNameTo
            fromCity.text =  DataClient.shared.offerPrice[indexPath!].cityNameFrom
            timeFrom.text = DataClient.shared.offerPrice[indexPath!].goTime
            timeTo.text =  DataClient.shared.offerPrice[indexPath!].arrivalTime
            dateFrom.text = DataClient.shared.offerPrice[indexPath!].goDate
            dateTo.text = DataClient.shared.offerPrice[indexPath!].arrivalDate
            price.text = DataClient.shared.offerPrice[indexPath!].price! + " SAR"
            
            APIClient.sendImageRequest(path: DataClient.shared.offerPrice[indexPath!].captainImage!, success: { (_ image) in
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideBackButton()
        
    }
    
    @IBAction func chooseAction(_ sender: Any) {
        if indexPath != nil {
            self.performSegue(withIdentifier: "toAddOffer", sender: self)
        }
    }
    
    @IBAction func chatAction(_ sender: Any) {
        if indexPath != nil {
            self.performSegue(withIdentifier: "toChat", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddOffer" {
            let vc = segue.destination as! AddOfferViewController
            if (type == 2) {
                vc.captainOfferId = DataClient.shared.offerPrice[indexPath!].id!
            }
            else {
                vc.captainOfferId = DataClient.shared.offer[indexPath!].id!
            }
        }
        if segue.identifier == "toChat" {
            let vc = segue.destination as! ChatViewController
            vc.senderType = .U
            if (type == 2) {
                vc.targetId = String(DataClient.shared.offerPrice[indexPath!].captainId!)
            }else {
                vc.targetId = String(DataClient.shared.offer[indexPath!].captainId!)
            }
            
        }
        
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "toPayment" {
    //            let vc = segue.destination as! OfferDetailsViewController
    //            vc.indexPath = self.indexPath
    //        }
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
