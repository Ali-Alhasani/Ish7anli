//
//  FilterOfferDetailsViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/22/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class FilterOfferDetailsViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {


    @IBOutlet weak var collectionView: UICollectionView!
    var indexPath:Int?
    var dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideBackButton()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width / 2.05)  , height: self.collectionView.frame.height * 0.40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  DataClient.shared.offerFiltered.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "NewOrder",
                                                       for: indexPath) as! NewOrderCollectionViewCell
        if (DataClient.shared.offerFiltered.count != 0 ){
            cell.setData(NewOrderCollectionViewData(price: DataClient.shared.offerFiltered[indexPath.row].price!, image: DataClient.shared.offerFiltered[indexPath.row].captainImage!, name: DataClient.shared.offerFiltered[indexPath.row].captainName!, time: DataClient.shared.offerFiltered[indexPath.row].goTime!, day: "", date: DataClient.shared.offerFiltered[indexPath.row].goDate!, cityFrom: DataClient.shared.offerFiltered[indexPath.row].cityNameTo! , cityTo: DataClient.shared.offerFiltered[indexPath.row].cityNameFrom!, stars: DataClient.shared.offerFiltered[indexPath.row].captainRate!, type: DataClient.shared.offerFiltered[indexPath.row].captainType))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.indexPath = indexPath.row
        self.performSegue(withIdentifier: "toFilterOfferDetails", sender: self)
        
    }
    
   
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFilterOfferDetails" {
            let vc = segue.destination as! OfferDetailsViewController
            vc.indexPath = self.indexPath
            vc.type = 3
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
