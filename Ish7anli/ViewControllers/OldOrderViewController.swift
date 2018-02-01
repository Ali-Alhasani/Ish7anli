//
//  OldOrderViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/11/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import PopupDialog
class OldOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,OldOrderWithRateTableViewDelegate,OldOrderTableViewDelegate  {
    
    
    
    
    
    func didPressRateButton(sender: UIButton) {
        showCustomDialog(indexPath: sender.tag)
    }
    
    var cellIsSelected: IndexPath?
    var indexPath:Int?
    @IBOutlet weak var tabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.hideBackButton()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Hide the Bcc Text Field , until CC gets focused in didSelectRowAtIndexPath()
        if cellIsSelected == indexPath {
            return 210
        }
        return 161
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataClient.shared.lastOffer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if DataClient.shared.lastOffer.count != 0 {
            if DataClient.shared.lastOffer[indexPath.row].status == 2 {
                let cell = Bundle.main.loadNibNamed("OldOrderTableViewCell", owner: self, options: nil)?.first as! OldOrderTableViewCell
                cell.setData(OldOrderTableViewData(price: DataClient.shared.lastOffer[indexPath.row].offerPrice!, image: DataClient.shared.lastOffer[indexPath.row].captainImage!, name: DataClient.shared.lastOffer[indexPath.row].captainName!, time: DataClient.shared.lastOffer[indexPath.row].time!, date: DataClient.shared.lastOffer[indexPath.row].date!, stars: DataClient.shared.lastOffer[indexPath.row].captainRate!, cityFrom: DataClient.shared.lastOffer[indexPath.row].addressSenderCity!, cityTo: DataClient.shared.lastOffer[indexPath.row].addressReceiverCity!))
                cell.detailsButton.tag = indexPath.row
                   cell.cellDelegate = self
                cell.selectionStyle = .none
                return cell
            }
            if DataClient.shared.lastOffer[indexPath.row].status == 3 {
                let cell = Bundle.main.loadNibNamed("OldOrderWithRateTableViewCell", owner: self, options: nil)?.first as! OldOrderWithRateTableViewCell
                cell.setData(OldOrderWithRateTableViewData(price: DataClient.shared.lastOffer[indexPath.row].offerPrice!, image: DataClient.shared.lastOffer[indexPath.row].captainImage!, name: DataClient.shared.lastOffer[indexPath.row].captainName!, time: DataClient.shared.lastOffer[indexPath.row].time!, date: DataClient.shared.lastOffer[indexPath.row].date!, stars: DataClient.shared.lastOffer[indexPath.row].captainRate!))
               
                cell.detailsButton.tag = indexPath.row
                cell.rateButton.tag = indexPath.row
                cell.cellDelegate = self
                cell.selectionStyle = .none
                return cell
            }
            
        }
        let cell = Bundle.main.loadNibNamed("OldOrderTableViewCell", owner: self, options: nil)?.first as! OldOrderTableViewCell

        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        cellIsSelected = cellIsSelected == indexPath ? nil : indexPath
        tableView.beginUpdates()
        tableView.endUpdates()
        
        
        
        
    }
    
    func didPressFinishedDetailsButton(sender: UIButton) {
        self.performSegue(withIdentifier: "toFinishedDetails", sender: self)
    }
    
    func didPressNonFinishedDetailsButton(sender: UIButton) {
        self.performSegue(withIdentifier: "toFinishedDetails", sender: self)
    }
    
    func load (){
        DataClient.shared.getOldOrder(success: {
            self.tabelView.reloadData()
        }) { (_ error) in
            let alert = UIAlertController(title: alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func loadRate(rate:Double , captainId:Int ,customerOfferId:Int ){
        DataClient.shared.rateCatpain(success: {
            
        }, failuer: { (_ error) in
            let alert = UIAlertController(title: alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }, customerOfferId: customerOfferId, captainId: captainId, rate: rate)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFinishedDetails" {
            let vc = segue.destination as! OrderDetails2ViewController
            vc.indexPath = self.cellIsSelected?.row
        }
      
    }
    
    func showCustomDialog(animated: Bool = true , indexPath:Int) {
        
        // Create a custom view controller
        let ratingVC = RatingViewController(nibName: "RatingViewController", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: ratingVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL", height: 60) {
            //self.label.text = "You canceled the rating dialog"
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "RATE", height: 60) {
         
            self.loadRate(rate: ratingVC.cosmosStarRating.rating, captainId: DataClient.shared.lastOffer[indexPath].captainId!, customerOfferId: DataClient.shared.lastOffer[indexPath].customerId!)
           
            //self.label.text = "You rated \(ratingVC.cosmosStarRating.rating) stars"
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: animated, completion: nil)
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
