//
//  RightViewController.swift
//  Tripper
//
//  Created by Ali Al-Hassany on 12/17/17.
//  Copyright © 2017 Ali Al-Hassany. All rights reserved.
//

import UIKit

enum LeftMenu:Int {
    case Notification = 0
    case AboutUs
    case CaptainLogin
    case ShareApp
    case ConnectUs
    case Logout
    
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}
class RightViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,LeftMenuProtocol {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["الإشعارات"  , "من نحن", "دخول كابتن", "نشر التطبيق", "راسلنا", "تسجيل خروج"]
  
    var iconMenus = ["notificationBlue","aboutUs","captain","share","contactUs","logout"]
    var NotificationViewController: UIViewController!
    var AboutUsViewController: UIViewController!
    var ContactUsTableViewController: UIViewController!
    var CaptainLoginViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if MOLHLanguage.isRTL() {
           // menus = []
        }else{
            menus = ["Notification","About Us","Captain Login","Share App","Contact Us","Logout"]
        }
        // Do any additional setup after loading the view.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let NotificationViewController = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.NotificationViewController = UINavigationController(rootViewController: NotificationViewController)
        

        let AboutUsViewController = storyboard.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
        self.AboutUsViewController = UINavigationController(rootViewController: AboutUsViewController)
        
        let ContactUsTableViewController = storyboard.instantiateViewController(withIdentifier: "ContactUsTableViewController") as! ContactUsTableViewController
        self.ContactUsTableViewController = UINavigationController(rootViewController: ContactUsTableViewController)
        

        let CaptainLoginViewController = storyboard.instantiateViewController(withIdentifier: "CaptainLoginViewController") as! CaptainLoginViewController
        self.CaptainLoginViewController =
        UINavigationController(rootViewController: CaptainLoginViewController)
        

        self.tableView.registerCellClass(DataTableViewCell.self)
        
       // self.imageHeaderView = ImageHeaderView.loadNib()
        //self.view.addSubview(self.imageHeaderView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .Notification:
            self.present(self.NotificationViewController, animated: true, completion: {
                self.slideMenuController()?.closeRight()
            })
        case .CaptainLogin:
            self.present(self.CaptainLoginViewController, animated: true, completion: {
                self.slideMenuController()?.closeRight()
            })
        
        case .AboutUs:
         
            self.present(self.AboutUsViewController, animated: true, completion: {
                self.slideMenuController()?.closeRight()
            })
            //self.slideMenuController()?.changeMainViewController(self.AboutUsViewController, close: true)
        case .ShareApp:
            share(message: "selam", link: "htttp://google.com")
            self.slideMenuController()?.closeRight()
        case .ConnectUs:
            self.present(self.ContactUsTableViewController, animated: true, completion: {
                self.slideMenuController()?.closeRight()
            })
            
        case .Logout:
            self.slideMenuController()?.closeRight()
            //self.slideMenuController()?.changeMainViewController(self.SettingsViewController, close: true)
        }

    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("DataTableViewCell", owner: self, options: nil)?.first as! DataTableViewCell
        cell.dataText.text = menus[indexPath.row]
        cell.dataImage.image = UIImage(named: iconMenus[indexPath.row])
        return cell
    }
    

    
    
    func share(message: String, link: String) {
        if let link = NSURL(string: link) {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
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
