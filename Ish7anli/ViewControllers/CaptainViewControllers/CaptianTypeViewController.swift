//
//  CaptianTypeViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/30/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
//var activationCodeC:String?
class CaptianTypeViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,CaptainTypeCollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func didPressChoose(sender: UIButton) {
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        spiningActivity.label.text = ErrorHelper.shared.loadingtitle
        spiningActivity.detailsLabel.text = ErrorHelper.shared.message
        load(index: sender.tag)
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var indexPath:Int?
    

    var array =  [ "هم فئة الكباتن الذين يمتلكون سيارات من نوع بيك اب وتصلهم اشعارات من الباب الى الباب  فقط","هذه الشارة للكابتن الذي يرغب في الشحن متى ما توافر طلب الشحن وسوف تصله جميع طلبات الشحن  ","هذه الشارة للكابتن الذي يرغب في الشحن وقت ما يرغب في السفر فقط ولا تصله الاشعارات إلا إذا سجل موعد السفر فقط"]
    
    var array2 = ["الشارة الصفراء","الشارة الحمراء", "الشارة الخضراء"]
    
    
    
    var fullname,
    cardNumber,
    mobile,
    email,
    password,accountNumber:String?
    
    var cardImage,licenceImage,carForm,contractImage,captainImage:String?
    var lat, lng:Double?
    var tilte,details:String?
    var cityId:Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        self.navigationController?.navigationBar.shadowImage = UIImage()
        //        self.navigationController?.navigationBar.isTranslucent = true
        //        
        if MOLHLanguage.isRTL() {
            
        }else {
         
            
            array = ["Captains who own a pick up cars, they want to collect orders and distribute it. so he will only receive notifications for delivery type door to door only.", "Captains who want to travel if there are  any available requests to charge.so the all notifications will arrive him.the delivery type is from the captain's location","Captains who determine his travel appointment, Notifications will arrive him if the travel scheduled, so the type of delivery is from the captain's location , so the delivery type is from the captain's location"]
            array2 = ["Yellow Sign","Red Sign","Green Sign"]
            
        }

        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackButton2()
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
        cell.setData(CaptainTypeCollectionViewData(type: array2[indexPath.row], image:  color(rawValue: indexPath.row)! , description: array[indexPath.row]))
        cell.chooseButton.tag = indexPath.row

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
    func load(index:Int){
        DataClient.shared.captainRegister(name: fullname!, email: email!, password: password!, phone: mobile!, cardNumber: cardNumber!, cardImage: cardImage!, licenseImage: licenceImage!, carForm: carForm!, contractImage: contractImage!, financialAccountNumber: accountNumber!, captainType: index+1, title: tilte!, details: details!, longitude: lng!, latitude: lat!,captainImage: captainImage!, cityId: cityId!, success: { (_ activationCode) in
           MBProgressHUD.hide(for: self.view, animated: true)
           //activationCodeC = activationCode
            var alartmessage:String?
            if MOLHLanguage.isRTL() {
                alartmessage = "تم تسجيل الكابتن بنجاح"
                
            }else{
                alartmessage = "the captain has been added successfully"
                
            }
            let alert = UIAlertController(title:  ErrorHelper.shared.alartTitle, message:alartmessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:  ErrorHelper.shared.ok, style: .default, handler: self.someHandler))
            self.present(alert, animated: true)
            
        }) { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
     
    
    }
    func someHandler(alert: UIAlertAction!) {
        self.performSegue(withIdentifier: "unwindFromAddVC21", sender: self)
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
