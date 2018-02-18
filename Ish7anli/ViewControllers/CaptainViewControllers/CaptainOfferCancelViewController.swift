//
//  CaptainOfferCancelViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/18/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CaptainOfferCancelViewController: UIViewController {

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
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var arrowImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if !MOLHLanguage.isRTL(){
            arrowImage.image = UIImage(named: "backBlueLeft")
        }
        if indexPath != nil {
            if DataClient.shared.myOffer[indexPath!].isDeleted! == 1 {
                cancelButton.isHidden = true
            }
            nameLabel.text = DataClient.shared.myOffer[indexPath!].captainName
            starsView.rating = DataClient.shared.myOffer[indexPath!].captainRate!
            destinationCity.text =  DataClient.shared.myOffer[indexPath!].cityNameTo
            fromCity.text =  DataClient.shared.myOffer[indexPath!].cityNameFrom
            timeFrom.text = DataClient.shared.myOffer[indexPath!].goTime
            timeTo.text =  DataClient.shared.myOffer[indexPath!].arrivalTime
            dateFrom.text = DataClient.shared.myOffer[indexPath!].goDate
            dateTo.text = DataClient.shared.myOffer[indexPath!].arrivalDate
            if MOLHLanguage.isRTL() {
                price.text = DataClient.shared.myOffer[indexPath!].price! + " ريال"
            }else{
                price.text = DataClient.shared.myOffer[indexPath!].price! + " SAR"
            }
            
            APIClient.sendImageRequest(path: DataClient.shared.myOffer[indexPath!].captainImage!, success: { (_ image) in
                self.imageView.image = image
            }, failure: { (_ error) in
                
            })
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackButton2()
  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseAction(_ sender: Any) {
        //self.performSegue(withIdentifier: "toAddOffer", sender: self)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
        spiningActivity.label.text = ErrorHelper.shared.loadingtitle
        spiningActivity.detailsLabel.text = ErrorHelper.shared.message
        DataClient.shared.cancelMyOfferCaptain(success: {
            MBProgressHUD.hide(for: self.view, animated: true)

            var alartmessage:String?
            if MOLHLanguage.isRTL() {
                alartmessage = "تم إلغاء الطلب بنجاح"
                
            }else{
                alartmessage = "the request has been canceled successfully"
                
            }
            let alert = UIAlertController(title:  ErrorHelper.shared.alartTitle, message:alartmessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:  ErrorHelper.shared.ok, style: .default, handler: self.someHandler))
            self.present(alert, animated: true)
            
        }, failuer: { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)

            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }, offerId:  DataClient.shared.myOffer[indexPath!].id!)
    }
    
    func someHandler(alert: UIAlertAction!) {
        self.performSegue(withIdentifier: "toMyOffer", sender: self)
        //self.dismiss(animated: true, completion: nil)
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
