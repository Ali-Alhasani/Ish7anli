//
//  tmpViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/11/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
 var ok,error,alartTitle,loadingtitle,message:String?
class MyOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TmpTableViewCellDelegate  {
    
    
    
  
    
    func didPressChoose(sender: UIButton) {
        self.loadChoose(customerOfferId: DataClient.shared.CustomerOrder[sender.tag].id!, captainId: DataClient.shared.CustomerOrder[(cellIsSelected?.row)!].bid[sender.tag].captainId!)
    }
    
    func didPressChat(sender: UIButton) {
        
    }
    
    
    var cellIsSelected: IndexPath?
    
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var weightImage: UIImageView!
    @IBOutlet weak var fromCityLabel: UILabel!
    @IBOutlet weak var destinationCityLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var arrowImage: UIImageView!
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    @IBAction func tapGestureAction(_ sender: Any) {
   self.performSegue(withIdentifier: "toMyOrderDetails", sender: self)
    }
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        nextButton.isEnabled = false
        previousButton.isEnabled = false
        
        if MOLHLanguage.isRTL() {
            
            ok = "موافق"
            alartTitle = "تنبيه"
        }else{
              arrowImage.image = UIImage(named: "backBlueLeft")
            ok = "Ok"
            alartTitle = "Alert"
            
        }
     
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Hide the Bcc Text Field , until CC gets focused in didSelectRowAtIndexPath()
        if cellIsSelected == indexPath {
            return 125
        }
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (DataClient.shared.CustomerOrder.count == 0) {
            return 0
        }else {
           // return 5
            return DataClient.shared.CustomerOrder[index].bid.count
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TmpTableViewCell", owner: self, options: nil)?.first as! TmpTableViewCell
        cell.selectionStyle = .none
        cell.setData(TmpTableViewCellData(price: DataClient.shared.CustomerOrder[index].bid[indexPath.row].price!, image: DataClient.shared.CustomerOrder[index].bid[indexPath.row].captainImage!, name: DataClient.shared.CustomerOrder[index].bid[indexPath.row].captainName!, stars: DataClient.shared.CustomerOrder[index].bid[indexPath.row].captainRate))
        cell.cellDelegate = self
        cell.chooseButton.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        cellIsSelected = cellIsSelected == indexPath ? nil : indexPath
        tableView.beginUpdates()
        tableView.endUpdates()
        
        
        
        
    }
    
    @IBAction func previousButton(_ sender: Any) {
             tmp()
         self.index -= 1
    
        self.view(index: index )
          self.tabelView.reloadData()
    }
    
    @IBAction func nextButton(_ sender: Any) {
          tmp()
          self.index += 1
        
          self.view(index: index)
        self.tabelView.reloadData()
      

        
    }
    func tmp(){
        if DataClient.shared.CustomerOrder.count != 0 && index == 0 {
            view(index: 0)
        }
        if DataClient.shared.CustomerOrder.count == 0 || index == DataClient.shared.CustomerOrder.endIndex {
            nextButton.isEnabled = false
        }else {
            nextButton.isEnabled = true
        }
         if DataClient.shared.CustomerOrder.count == 0 || index == DataClient.shared.CustomerOrder.startIndex {
            previousButton.isEnabled = false
            
        }else {
            previousButton.isEnabled = true
        }
    }
    
    func load (){
        DataClient.shared.getCustomerOrder(success: {
            self.tabelView.reloadData()
            self.tmp()
            print(DataClient.shared.CustomerOrder.count)
        }) { (_ error) in
         
            let alert = UIAlertController(title: alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func loadChoose(customerOfferId: Int, captainId: Int){
        //print(customerOfferId)
        //print(captainId)
        DataClient.shared.chooseCaptain(success: {
            self.tabelView.reloadData()
        }, failuer: { (_ error) in
            let alert = UIAlertController(title: alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ok, style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }, customerOfferId: customerOfferId, captainId: captainId)
    }
    
    
    func view (index:Int){
        if (index != DataClient.shared.CustomerOrder.endIndex) {
        dateLabel.text = DataClient.shared.CustomerOrder[index].date! + " - " +  DataClient.shared.CustomerOrder[index].time!
        fromCityLabel.text = DataClient.shared.CustomerOrder[index].addressSenderCity!
        destinationCityLabel.text = DataClient.shared.CustomerOrder[index].addressReceiverCity!
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMyOrderDetails" {
            let vc = segue.destination as! OrderDetailsViewController
            vc.indexPath = self.cellIsSelected?.row
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
