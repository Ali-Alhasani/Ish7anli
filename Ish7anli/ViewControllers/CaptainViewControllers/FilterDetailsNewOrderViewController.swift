//
//  FilterDetailsNewOrderViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/22/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class FilterDetailsNewOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
 @IBOutlet weak var tableView: UITableView!
    var indexPath:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 160
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // self.navigationController?.navigationBar.isTranslucent = false
     
        self.hideBackButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataClient.shared.cpatainCustomerOrderFiltered.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("newOrderTableViewCell", owner: self, options: nil)?.first as! newOrderTableViewCell
        cell.selectionStyle = .none
        if (DataClient.shared.cpatainCustomerOrderFiltered.count != 0) {
            if (DataClient.shared.cpatainCustomerOrderFiltered[indexPath.row].price! == "0") {
                cell.setData(newOrderTableViewData(price: DataClient.shared.cpatainCustomerOrderFiltered[indexPath.row].price!, image:  DataClient.shared.cpatainCustomerOrderFiltered[indexPath.row].customerImage!, name:  DataClient.shared.cpatainCustomerOrderFiltered[indexPath.row].customerName!, senderCity:  DataClient.shared.cpatainCustomerOrderFiltered[indexPath.row].addressSenderTitle!, receiverCity:  DataClient.shared.cpatainCustomerOrderFiltered[indexPath.row].addressReceiverTitle!, isNew: true ))
            }else{
                cell.setData(newOrderTableViewData(price: DataClient.shared.cpatainCustomerOrderFiltered[indexPath.row].price!, image:  DataClient.shared.cpatainCustomerOrderFiltered[indexPath.row].customerImage!, name:  DataClient.shared.cpatainCustomerOrderFiltered[indexPath.row].customerName!, senderCity:  DataClient.shared.cpatainCustomerOrderFiltered[indexPath.row].addressSenderTitle!, receiverCity:  DataClient.shared.cpatainCustomerOrderFiltered[indexPath.row].addressReceiverTitle!, isNew: false ))
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.indexPath = indexPath.row
        self.performSegue(withIdentifier: "toFilteredNewOrderDetails", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFilteredNewOrderDetails" {
            let vc = segue.destination as! CpatainNewOrderDetailsViewController
            vc.indexPath = self.indexPath
            vc.isFiltered = true
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
