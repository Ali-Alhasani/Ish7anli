//
//  CaptainOfferViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/27/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CaptainOfferViewController2: UIViewController,IndicatorInfoProvider,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var indexPath:Int?
    var refreshControl = UIRefreshControl()
    var dateFormatter = DateFormatter()
    var itemInfo: IndicatorInfo = ""

    override func viewDidLoad() {
        
        super.viewDidLoad()
       // self.tableView?.rowHeight = UITableViewAutomaticDimension
 
        load()
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refreshControl.addTarget(self, action: #selector(self.PullRefresh), for: UIControlEvents.valueChanged)
        self.collectionView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }
    @objc func PullRefresh()
    {
        //loading = true
        DispatchQueue.main.async {
            let now = NSDate()
            let updateString = "last update was" + self.dateFormatter.string(from: now as Date)
            
            self.refreshControl.attributedTitle = NSAttributedString(string: updateString)
            self.Refreshload()
            
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
        self.Refreshload()
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if MOLHLanguage.isRTL() {
            itemInfo = "الاقل سعراً"
        }else {
            itemInfo = "Lowest Price"
        }
        
        return itemInfo
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width / 2.05)  , height: self.collectionView.frame.height * 0.48)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  DataClient.shared.captianPriceOffer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "NewOrder2",
                                                       for: indexPath) as! NewOrderCollectionViewCell
        if (DataClient.shared.captianPriceOffer.count != 0 ){
            cell.setData(NewOrderCollectionViewData(price: DataClient.shared.captianPriceOffer[indexPath.row].price!, image: DataClient.shared.captianPriceOffer[indexPath.row].captainImage!, name: DataClient.shared.captianPriceOffer[indexPath.row].captainName!, time: DataClient.shared.captianPriceOffer[indexPath.row].goTime!, day: "", date: DataClient.shared.captianPriceOffer[indexPath.row].goDate!, cityFrom: DataClient.shared.captianPriceOffer[indexPath.row].cityNameTo!, cityTo: DataClient.shared.captianPriceOffer[indexPath.row].cityNameFrom!, stars: DataClient.shared.captianPriceOffer[indexPath.row].captainRate!, type: DataClient.shared.captianPriceOffer[indexPath.row].captainType))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.indexPath = indexPath.row
        self.performSegue(withIdentifier: "toOfferDetailsCaptain2", sender: self)
        
    }
    func load(){
        DataClient.shared.getCaptianPrieOffer(success: {
           // self.collectionView.reloadData()
        }) { (_ error) in
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func Refreshload(){
        DataClient.shared.getCaptianPrieOffer(success: {
            self.collectionView.reloadData()
        }) { (_ error) in
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOfferDetailsCaptain2" {
            let vc = segue.destination as! CaptainOfferDetailsViewController
            vc.indexPath = self.indexPath
            vc.type = 2
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