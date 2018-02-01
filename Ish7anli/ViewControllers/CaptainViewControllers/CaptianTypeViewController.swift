//
//  CaptianTypeViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/30/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CaptianTypeViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,CaptainTypeCollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func didPressChoose(sender: UIButton) {
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        if MOLHLanguage.isRTL() {
          loadingtitle = "جارى الإرسال"
          message = "الرجاء الانتظار"
        }else{
           loadingtitle = "Sending"
           message = "Please Wait"
        }
        spiningActivity.label.text = loadingtitle
        spiningActivity.detailsLabel.text = message
        
       load()
    }
    

    @IBOutlet weak var collectionView: UICollectionView!
    var indexPath:Int?
    var array = ["هم فئة الكباتن الذين لديهم مواعيد محددة للسفر وتصلهم الاشعارات اذا سجلو موعد للسفر, لذلك نوع التوصيل من موقع الكابتن" , "هم فئة الكباتن الذين يرغبون بالسفر و الشحن وقتما توفرت الطلبات , وتصلهم جميع الاشعارات لذلك نوع التوصيل من موقع الكابتن", "هم فئة الكباتن الذين لا يرغبون بالسفر , بينما يرغبون بتجميع الطلبات لذلك نوع التوصيل من الباب للباب"]

    
    var array2 = ["الشارة الحمراء" , "الشارة الخضراء" , "الشارة الصفراء"]
    var fullname,
    cardNumber,
    mobile,
    email,
    password,accountNumber:String?
    
       var cardImage,licenceImage,carForm,contractImage:String?
    

    @IBOutlet weak var button1: RadioButtonGray!
    @IBOutlet weak var button2: RadioButtonGray!
    @IBOutlet weak var button3: RadioButtonGray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        if MOLHLanguage.isRTL() {
          
        }else {
            
            array = ["Captains who determine his travel appointment, Notifications will arrive him if the travel scheduled, so the type of delivery is from the captain's location , so the delivery type is from the captain's location" , "Captains who want to travel if there are  any available requests to charge.so the all notifications will arrive him.the delivery type is from the captain's location", "Captains who don't want to travel, they want to collect orders and distribute it. so the  delivery type is from door to door."]
            array2 = ["Green Sign" , "Red Sign" , "Yellow Sign"]
            
        }
        button1.alternateButton = [button2,button3]
        button2.alternateButton = [button1,button3]
        button3.alternateButton = [button1,button2]


        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackButton()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width)  , height: self.collectionView.frame.height )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "Type",
                                                       for: indexPath) as! CaptainTypeCollectionViewCell
        cell.cellDelegate = self
        cell.setData(CaptainTypeCollectionViewData(type: array2[indexPath.row], image: "String", description: array[indexPath.row], image1: "String", image2: "String", image3: ""))
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.indexPath = indexPath.row
        //self.performSegue(withIdentifier: "toOfferDetails", sender: self)
        
    }
    
    

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
//
//    @IBAction func tapGestureAction(_ sender: Any) {
//      //  cellDelegate?.didPressMove(sender: 0)
//        image1.
//    }
//
//    @IBAction func tapGestureImage2Action(_ sender: Any) {
//       // cellDelegate?.didPressMove(sender: 1)
//    }
//
//    @IBAction func tapGestureImage3Action(_ sender: Any) {
//        //cellDelegate?.didPressMove(sender: 2)
//    }
//
    
    @IBAction func button1(_ sender: Any) {
        
    }
    
    @IBAction func button2(_ sender: Any) {
           let section = 0
        let lastItemIndex = self.collectionView.numberOfItems(inSection: section) - 1
        let indexPath:NSIndexPath = NSIndexPath(item: lastItemIndex, section: section)
        self.collectionView.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: false)
        
//        let delayTime = dispatch_time(DispatchTime.now(), Int64(0.5 * Double(NSEC_PER_SEC)));)
//        dispatch_after(delayTime, dispatch_get_main_queue()) do {
//            print(self.collectionView.indexPathsForVisibleItems())
//        }
    }
    
    @IBAction func button3(_ sender: Any) {
        
    }
    func load(){
      
        DataClient.shared.captainRegister(name: fullname!, email: email!, password: password!, phone: SessionManager.shared.phoneNumber, cardNumber: cardNumber!, cardImage: cardImage!, licenseImage: licenceImage!, carForm: carForm!, contractImage: contractImage!, financialAccountNumber: accountNumber! , captainType: 1, success: {
            MBProgressHUD.hide(for: self.view, animated: true)

            print("fucking done")
        }) { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title: alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ok, style: .default, handler: nil))
            self.present(alert, animated: true)
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