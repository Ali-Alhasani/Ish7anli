//
//  CpatainActiveOrderViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/27/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CpatainActiveOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var indexPath:Int?
     var ok,error,alartTitle,loadingtitle,message:String?
    var refreshControl = UIRefreshControl()
    var dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
    

load()
       

        self.tableView?.rowHeight = 230
        if MOLHLanguage.isRTL() {
            ok = "موافق"
            alartTitle = "تنبيه"
        }else{
            ok = "Ok"
            alartTitle = "Alert"
            
        }
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
        let cell = Bundle.main.loadNibNamed("ActiveOrderTableViewCell", owner: self, options: nil)?.first as! ActiveOrderTableViewCell
        cell.selectionStyle = .none
        cell.setData(ActiveOrderTableViewData(price: DataClient.shared.cpatainActiveOrder[indexPath.row].price!, image: DataClient.shared.cpatainActiveOrder[indexPath.row].customerImage!, name: DataClient.shared.cpatainActiveOrder[indexPath.row].customerName!,cityFrom: DataClient.shared.cpatainActiveOrder[indexPath.row].addressSenderCity!, cityTo: DataClient.shared.cpatainActiveOrder[indexPath.row].addressReceiverCity!))
        if (DataClient.shared.cpatainActiveOrder[indexPath.row].status == 1 ) {
            cell.actionButton.setTitle("Recevied Done", for: UIControlState.normal)
            //cell.actionButton.backgroundColor = UIColor(named: "niceBlue")
            cell.actionButton.backgroundColor = UIColor.red
            //cell.isChecked = true
        }else if (DataClient.shared.cpatainActiveOrder[indexPath.row].status == 2){
               cell.isChecked = false
               cell.actionButton.setTitle("Delivery Done", for: UIControlState.normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.indexPath = indexPath.row
        self.performSegue(withIdentifier: "toActiveOrderDetails", sender: self)
        
        
        
        
    }
    
    
    func load(){
        DataClient.shared.getActiveOrder(success: {
            self.tableView.reloadData()
        }) { (_ error) in
            let alert = UIAlertController(title: self.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: self.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toActiveOrderDetails" {
            let vc = segue.destination as! CaptainActiveOrderDetailsViewController
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
