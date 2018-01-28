//
//  NewOrderViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/16/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class NewOrderViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var indexPath:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
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
            self.collectionView.reloadData()
        }) { (_ error) in
            print(error)
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
