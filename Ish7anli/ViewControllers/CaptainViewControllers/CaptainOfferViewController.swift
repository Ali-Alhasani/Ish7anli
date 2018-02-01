//
//  CaptainOfferViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/27/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CaptainOfferViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var indexPath:Int?
    var ok,error,alartTitle,loadingtitle,message:String?

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.tableView?.rowHeight = UITableViewAutomaticDimension
        if MOLHLanguage.isRTL() {
            ok = "موافق"
            alartTitle = "تنبيه"
        }else{
            ok = "Ok"
            alartTitle = "Alert"
            
        }
load()
    
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
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  DataClient.shared.captianOffer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "NewOrder2",
                                                       for: indexPath) as! NewOrderCollectionViewCell
        if (DataClient.shared.captianOffer.count != 0 ){
                cell.setData(NewOrderCollectionViewData(price: DataClient.shared.captianOffer[indexPath.row].price!, image: DataClient.shared.captianOffer[indexPath.row].captainImage!, name: DataClient.shared.captianOffer[indexPath.row].captainName!, time: DataClient.shared.captianOffer[indexPath.row].goTime!, day: "", date: DataClient.shared.captianOffer[indexPath.row].goDate!, cityFrom: DataClient.shared.captianOffer[indexPath.row].cityNameFrom!, cityTo: DataClient.shared.captianOffer[indexPath.row].cityNameTo!, stars: DataClient.shared.captianOffer[indexPath.row].captainRate!))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.indexPath = indexPath.row
        self.performSegue(withIdentifier: "toOfferDetailsCaptain", sender: self)
        
    }
    func load(){
        DataClient.shared.getCaptianOffer(success: {
            self.collectionView.reloadData()
        }) { (_ error) in
            let alert = UIAlertController(title: self.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: self.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOfferDetailsCaptain" {
            let vc = segue.destination as! CaptainOfferDetailsViewController
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