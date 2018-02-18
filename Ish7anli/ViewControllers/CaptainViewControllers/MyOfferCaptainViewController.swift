//
//  MyOfferCaptainViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/17/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class MyOfferCaptainViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backButton: UIBarButtonItem!

    var dateFormatter = DateFormatter()
    var indexPath:Int?

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(self.PullRefresh),for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.black
        
        return refreshControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.addSubview(self.refreshControl)
        load()
        // Do any additional setup after loading the view.
        if !MOLHLanguage.isRTL() {
            backButton.image = UIImage(named: "leftback")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideBackButton()
     
     
        
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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width / 2.05)  , height: self.collectionView.frame.height * 0.40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  DataClient.shared.myOffer.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "NewOrder",
                                                       for: indexPath) as! NewOrderCollectionViewCell
        if (DataClient.shared.myOffer.count != 0 ){
            cell.setData(NewOrderCollectionViewData(price: DataClient.shared.myOffer[indexPath.row].price!, image: DataClient.shared.myOffer[indexPath.row].captainImage!, name: DataClient.shared.myOffer[indexPath.row].captainName!, time: DataClient.shared.myOffer[indexPath.row].goTime!, day: "", date: DataClient.shared.myOffer[indexPath.row].goDate!, cityFrom: DataClient.shared.myOffer[indexPath.row].cityNameTo!, cityTo:  DataClient.shared.myOffer[indexPath.row].cityNameFrom! , stars: DataClient.shared.myOffer[indexPath.row].captainRate!))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.indexPath = indexPath.row
        self.performSegue(withIdentifier: "toOfferCancel", sender: self)
        
    }
    
    
    func load(){
        DataClient.shared.myOfferCaptain(success: {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }) { (_ error) in
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    

    @IBAction func unwindFromAddVC211(_ sender: UIStoryboardSegue){
          self.load()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOfferCancel" {
            let vc = segue.destination as! CaptainOfferCancelViewController
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
