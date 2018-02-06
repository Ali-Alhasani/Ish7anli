//
//  NewOrderViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/16/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class NewOrderViewController: UIViewController,IndicatorInfoProvider,UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{

    
    @IBOutlet weak var collectionView: UICollectionView!
    var indexPath:Int?
      var itemInfo: IndicatorInfo = ""
    var refreshControl = UIRefreshControl()
    var dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refreshControl.addTarget(self, action: #selector(self.PullRefresh), for: UIControlEvents.valueChanged)
        self.collectionView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.hideBackButton()
        
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if MOLHLanguage.isRTL() {
            itemInfo = "الأعلى تقييماً"
        }else {
            itemInfo = "Highest Rate"
        }
        
        return itemInfo
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

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width / 2.05)  , height: self.collectionView.frame.height * 0.48)
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  DataClient.shared.offer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "NewOrder",
                                                       for: indexPath) as! NewOrderCollectionViewCell
        if (DataClient.shared.offer.count != 0 ){
        cell.setData(NewOrderCollectionViewData(price: DataClient.shared.offer[indexPath.row].price!, image: DataClient.shared.offer[indexPath.row].captainImage!, name: DataClient.shared.offer[indexPath.row].captainName!, time: DataClient.shared.offer[indexPath.row].goTime!, day: "", date: DataClient.shared.offer[indexPath.row].goDate!, cityFrom: DataClient.shared.offer[indexPath.row].cityNameFrom!, cityTo: DataClient.shared.offer[indexPath.row].cityNameTo!, stars: DataClient.shared.offer[indexPath.row].captainRate!))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.indexPath = indexPath.row
        self.performSegue(withIdentifier: "toOfferDetails", sender: self)

    }
    
    
    func load(){
        DataClient.shared.getOffer(success: {
              DispatchQueue.main.async {
               self.collectionView.reloadData()
            }
        }) { (_ error) in
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func unwindFromAddVC2(_ sender: UIStoryboardSegue){
        
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOfferDetails" {
            let vc = segue.destination as! OfferDetailsViewController
            vc.indexPath = self.indexPath
        }
    }

}
