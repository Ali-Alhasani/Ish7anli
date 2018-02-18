//
//  NotificationViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/16/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var refreshControl = UIRefreshControl()
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.tableFooterView = UIView()
        if !MOLHLanguage.isRTL() {
            backButton.image = UIImage(named: "leftback")
        }
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refreshControl.addTarget(self, action: #selector(self.PullRefresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl)
         self.tableView?.rowHeight = 78
        load()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        // Hide the Bcc Text Field , until CC gets focused in didSelectRowAtIndexPath()
//
//        return 78
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataClient.shared.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = Bundle.main.loadNibNamed("NotificationsTableViewCell", owner: self, options: nil)?.first as! NotificationsTableViewCell
        
        if DataClient.shared.notifications.count != 0 {
            if SessionManager.shared.isUserLogged {
            
            cell.setData(NotificationsTableViewData(name: DataClient.shared.notifications[indexPath.row].customerTitle!, time: ""))
            } else {
                  cell.setData(NotificationsTableViewData(name: DataClient.shared.notifications[indexPath.row].adminTitle!, time: ""))
            }
       
        }
         cell.selectionStyle = .none
        return cell
        
    }
    
    
    func load(){
        DataClient.shared.notifications(success: {
            print( DataClient.shared.notifications)
            self.tableView.reloadData()
        }) { (_ error) in
            print(error)
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
