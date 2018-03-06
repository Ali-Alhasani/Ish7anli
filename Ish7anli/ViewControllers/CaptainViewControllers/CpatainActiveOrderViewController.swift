//
//  CpatainActiveOrderViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/27/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CpatainActiveOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ActiveOrderTableViewDelegate,ActiveOrderTableViewDelegate2 {
    
    @IBOutlet weak var tableView: UITableView!
    var indexPath:Int?
    
    var refreshControl = UIRefreshControl()
    var dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        load()
        
        
        self.tableView?.rowHeight = 230
        
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refreshControl.addTarget(self, action: #selector(self.PullRefresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }
    @objc func PullRefresh()
    {
        //loading = true
        DispatchQueue.main.async {
            let now = NSDate()
            let updateString = "last update was" + self.dateFormatter.string(from: now as Date)
            
            self.refreshControl.attributedTitle = NSAttributedString(string: updateString)
            self.load()
            
            if self.refreshControl.isRefreshing
            {
                self.refreshControl.endRefreshing()
            }
            
            return
        }
        
        
    }
    func didPressNonFinishedDetailsButton(sender: UIButton) {
        if DataClient.shared.cpatainActiveOrder[sender.tag].status == 1 {
            recevied(indexPath: sender.tag)
        }else {
            delivery(indexPath: sender.tag)
        }
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
        
        return DataClient.shared.cpatainActiveOrder.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = Bundle.main.loadNibNamed("ActiveOrderTableViewCell", owner: self, options: nil)?.first as! ActiveOrderTableViewCell
        if DataClient.shared.cpatainActiveOrder.count != 0 {
            if (DataClient.shared.cpatainActiveOrder[indexPath.row].status == 1 ) {
                let cell = Bundle.main.loadNibNamed("ActiveOrderTableViewCell", owner: self, options: nil)?.first as! ActiveOrderTableViewCell
                cell.selectionStyle = .none
                cell.cellDelegate = self
                cell.actionButton.setTitle("Recevied Done", for: UIControlState.normal)
                cell.middlePointLabel.backgroundColor = UIColor.white
                cell.setData(ActiveOrderTableViewData(price: DataClient.shared.cpatainActiveOrder[indexPath.row].price!, image: DataClient.shared.cpatainActiveOrder[indexPath.row].customerImage!, name: DataClient.shared.cpatainActiveOrder[indexPath.row].customerName!,cityFrom: DataClient.shared.cpatainActiveOrder[indexPath.row].addressSenderTitle!, cityTo: DataClient.shared.cpatainActiveOrder[indexPath.row].addressReceiverTitle!, type: 1))
                
                // cell.actionButton.backgroundColor = UIColor.red
                cell.actionButton.tag = indexPath.row
                //cell.isChecked = true
                return cell
            }
            if (DataClient.shared.cpatainActiveOrder[indexPath.row].status == 2){
                let cell = Bundle.main.loadNibNamed("ActiveOrderTableViewCell2", owner: self, options: nil)?.first as! ActiveOrderTableViewCell2
                // cell.isChecked = false
                cell.selectionStyle = .none
                cell.cellDelegate = self
                cell.actionButton.tag = indexPath.row
                
                cell.setData(ActiveOrderTableViewData(price: DataClient.shared.cpatainActiveOrder[indexPath.row].price!, image: DataClient.shared.cpatainActiveOrder[indexPath.row].customerImage!, name: DataClient.shared.cpatainActiveOrder[indexPath.row].customerName!,cityFrom: DataClient.shared.cpatainActiveOrder[indexPath.row].addressSenderTitle!, cityTo: DataClient.shared.cpatainActiveOrder[indexPath.row].addressSenderTitle!, type: 2))
                cell.actionButton.setTitle("Delivery Done", for: UIControlState.normal)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.indexPath = indexPath.row
        if DataClient.shared.cpatainActiveOrder.count != 0 {
            self.performSegue(withIdentifier: "toActiveOrderDetails", sender: self)
        }
        
        
        
    }
    
    
    func load(){
        DataClient.shared.getActiveOrder(success: {
            self.tableView.reloadData()
        }) { (_ error) in
               self.tableView.reloadData()
            let alert = UIAlertController(title:ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func RefreshLoad(){
        DataClient.shared.getActiveOrder(success: {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.reloadData()
        }) { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.reloadData()
            let alert = UIAlertController(title:ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toActiveOrderDetails" {
            let vc = segue.destination as! CaptainActiveOrderDetailsViewController
            vc.indexPath = self.indexPath
        }
    }
    
    func recevied(indexPath:Int){
        DataClient.shared.receivedOffer(success: {
            MBProgressHUD.hide(for: self.view, animated: true)
            print("recevied done")
            var alartmessage:String?
            if MOLHLanguage.isRTL() {
                alartmessage = "تم اضافة الطلب بنجاح"
                
            }else{
                alartmessage = "the request has been added successfully"
                
            }
            let alert = UIAlertController(title:  ErrorHelper.shared.alartTitle, message:alartmessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:  ErrorHelper.shared.ok, style: .default, handler: self.someHandler))
            self.present(alert, animated: true)
            
        }, failuer: { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }, customerOfferId: DataClient.shared.cpatainActiveOrder[indexPath].id!)
    }
    func delivery(indexPath:Int){
        DataClient.shared.deliveryOffer(success: {
            MBProgressHUD.hide(for: self.view, animated: true)
            var alartmessage:String?
            if MOLHLanguage.isRTL() {
                alartmessage = "تم اضافة الطلب بنجاح"
                
            }else{
                alartmessage = "the request has been added successfully"
                
            }
            let alert = UIAlertController(title:  ErrorHelper.shared.alartTitle, message:alartmessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:  ErrorHelper.shared.ok, style: .default, handler: self.someHandler))
            self.present(alert, animated: true)
        }, failuer: { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }, customerOfferId: DataClient.shared.cpatainActiveOrder[indexPath].id!)
    }
    
    func someHandler(alert: UIAlertAction!) {
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spiningActivity.label.text = ErrorHelper.shared.loadingtitle
        spiningActivity.detailsLabel.text = ErrorHelper.shared.message
        
        RefreshLoad()
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
