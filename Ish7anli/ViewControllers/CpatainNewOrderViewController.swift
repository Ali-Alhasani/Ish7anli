//
//  CpatainNewOrderViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/27/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CpatainNewOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var indexPath:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
         load()
        self.tableView.rowHeight = 160

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
            return DataClient.shared.cpatainCustomerOrder.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("newOrderTableViewCell", owner: self, options: nil)?.first as! newOrderTableViewCell
        cell.selectionStyle = .none
        cell.setData(newOrderTableViewData(price: DataClient.shared.cpatainCustomerOrder[indexPath.row].price!, image:  DataClient.shared.cpatainCustomerOrder[indexPath.row].customerImage!, name:  DataClient.shared.cpatainCustomerOrder[indexPath.row].customerName!, senderCity:  DataClient.shared.cpatainCustomerOrder[indexPath.row].addressSenderCity!, receiverCity:  DataClient.shared.cpatainCustomerOrder[indexPath.row].addressReceiverCity!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.indexPath = indexPath.row
        self.performSegue(withIdentifier: "toNewOrderDetails", sender: self)
        
    }
    
    
    @IBAction func addOffer(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddOffer", sender: self)
    }
    
    
    
    
    func load(){
        DataClient.shared.getNewOfferCaptain(success: {
            self.tableView.reloadData()
        }) { (_ error) in
            
        }
    }
    
    @IBAction func unwindFromAddVC3(_ sender: UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewOrderDetails" {
            let vc = segue.destination as! CpatainNewOrderDetailsViewController
            vc.indexPath = self.indexPath
        }
        
        if segue.identifier == "toAddOffer" {
            let vc = segue.destination as! CaptainAddOfferViewController
            vc.indexPath = self.indexPath
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
