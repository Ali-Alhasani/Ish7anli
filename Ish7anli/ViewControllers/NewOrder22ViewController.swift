//
//  NewOrder22ViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/30/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class NewOrder22ViewController: UIViewController,IndicatorInfoProvider,UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var indexPath:Int?
      var itemInfo: IndicatorInfo = ""
    var refreshControl = UIRefreshControl()
    var dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        if MOLHLanguage.isRTL() {
            ok = "موافق"
            alartTitle = "تنبيه"
        }else{
            ok = "Ok"
            alartTitle = "Alert"
            
        }
        // Do any additional setup after loading the view.
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        
        refreshControl.addTarget(self, action: #selector(self.PullRefresh), for: UIControlEvents.valueChanged)
        self.collectionView.addSubview(refreshControl)
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
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if MOLHLanguage.isRTL() {
            itemInfo = "الاقل سعراً"
        }else {
            itemInfo = "Lowest Price"
        }
        
        return itemInfo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.hideBackButton()
        self.collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width * 0.485 , height: self.collectionView.frame.height * 0.4)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  DataClient.shared.offerPrice.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "NewOrder",
                                                       for: indexPath) as! NewOrderCollectionViewCell
        if (DataClient.shared.offerPrice.count != 0 ){
            cell.setData(NewOrderCollectionViewData(price: DataClient.shared.offerPrice[indexPath.row].price!, image: DataClient.shared.offerPrice[indexPath.row].captainImage!, name: DataClient.shared.offerPrice[indexPath.row].captainName!, time: DataClient.shared.offerPrice[indexPath.row].goTime!, day: "", date: DataClient.shared.offerPrice[indexPath.row].goDate!, cityFrom: DataClient.shared.offerPrice[indexPath.row].cityNameFrom!, cityTo: DataClient.shared.offerPrice[indexPath.row].cityNameTo!, stars: DataClient.shared.offerPrice[indexPath.row].captainRate!))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.indexPath = indexPath.row
        self.performSegue(withIdentifier: "toOfferDetails2", sender: self)
        
    }
    
    
    func load(){
        DataClient.shared.getPriceOffer(success: {
           // self.collectionView.reloadData()
        }) { (_ error) in
            let alert = UIAlertController(title: alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ok, style: .default, handler: nil))
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
        if segue.identifier == "toOfferDetails2" {
            let vc = segue.destination as! OfferDetailsViewController
            vc.indexPath = self.indexPath
            vc.type = 2 
        }
    }

}
