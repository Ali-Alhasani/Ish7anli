//
//  CaptianArchiveOrderViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/27/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CaptianArchiveOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var indexPath:Int?
    var refreshControl = UIRefreshControl()
    var dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.rowHeight = 150

load()
 
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refreshControl.addTarget(self, action: #selector(self.PullRefresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataClient.shared.captianArchiveOrder.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ArchiveOrderTableViewCell", owner: self, options: nil)?.first as! ArchiveOrderTableViewCell
        cell.selectionStyle = .none
        cell.setData(ArchiveOrderTableViewData(price: DataClient.shared.captianArchiveOrder[indexPath.row].offerPrice!, image: DataClient.shared.captianArchiveOrder[indexPath.row].customerImage!, name: DataClient.shared.captianArchiveOrder[indexPath.row].customerName!, senderCity: DataClient.shared.captianArchiveOrder[indexPath.row].addressSenderCity!, receiverCity: DataClient.shared.captianArchiveOrder[indexPath.row].addressReceiverCity!, rate: DataClient.shared.captianArchiveOrder[indexPath.row].offerRate!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.indexPath = indexPath.row
        self.performSegue(withIdentifier: "toArchiveOrderDetails", sender: self)
        
        
        
        
    }
    
    
    
    func load(){
        DataClient.shared.getCaptianArchiveOrder(success: {
            self.tableView.reloadData()
        }) { (_ error) in
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toArchiveOrderDetails" {
            let vc = segue.destination as! CaptainArchiveOrderDetailsViewController
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
