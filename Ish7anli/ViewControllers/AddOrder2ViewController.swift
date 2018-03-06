//
//  AddOrder2ViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/25/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class AddOrder2ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel = AddressViewModel2()
    
    var receiverAddress,senderAddress,weghitIndex,deliveryIndex,senderCity, receiverCity:Int?
    
    var receiverName:String?
    var receiverPhone:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        viewModel.delegate = self
        
        tableView?.dataSource = viewModel
        self.tableView.delegate = self.viewModel
        
        self.tableView?.estimatedRowHeight = 100
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        
        
        self.tableView?.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
        self.tableView?.register(AddAddressTableViewCell.nib, forCellReuseIdentifier: AddAddressTableViewCell.identifier)
          self.tableView?.register(TextViewTableViewCell.nib, forCellReuseIdentifier: TextViewTableViewCell.identifier)
        self.tableView?.register(SubmitButtonTableViewCell.nib, forCellReuseIdentifier: SubmitButtonTableViewCell.identifier)
        
        viewModel.addListener()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideBackButton()
         viewModel.addListener()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPayment2" {
            
            let vc = segue.destination as! PaymentMethodViewController
            vc.receiveAddress = receiverAddress!
            vc.type = deliveryIndex!
            vc.senderAddress = senderAddress!
            vc.weghitIndex = weghitIndex!
            vc.receiverName = receiverName!
           vc.receiverPhone = receiverPhone!
        }
    }
    @IBAction func savePlayerDetail(_ segue: UIStoryboardSegue) {
        
        guard let AddAddressViewController = segue.source as? AddAddressViewController  else {
            return
        }
        viewModel.addListener()
        
    }
    

}
extension AddOrder2ViewController: AddressViewModel2Delegate {
    
    func move2(_ receiverAddress: Int, information: [Int] , _ receiverCity:Int) {
       
        
        let multilineCell = tableView.cellForRow(at: IndexPath(row: information.first!, section: 2)) as? TextViewTableViewCell
        let multilineCell2 = tableView.cellForRow(at: IndexPath(row: information.last!, section: 2)) as? TextViewTableViewCell
        // (index: ))
        //cellForRow(at: ) as? TextViewTableViewCell // we cast here so that you can access your custom property.
        self.receiverAddress = receiverAddress
        self.receiverName =   multilineCell!.textView.text!
        self.receiverPhone = multilineCell2!.textView.text!
        
        if (senderAddress! == receiverAddress){
            MBProgressHUD.hide(for: self.view, animated: true)
            var alartmessage:String?
            if MOLHLanguage.isRTL() {
                alartmessage = "عذراً لا يمكن إضافة نفس عنوان المرسل والمستقبل للتوصيل"
                
            }else{
                alartmessage = "You cant add the same sender and receiver address"
                
            }
            let alert = UIAlertController(title:  ErrorHelper.shared.alartTitle, message:alartmessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:  ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if (senderCity! == receiverCity){
            MBProgressHUD.hide(for: self.view, animated: true)
            var alartmessage:String?
            if MOLHLanguage.isRTL() {
                alartmessage = "عذراً لا يمكن اضافة نفس المدينة في العنوان المرسل والمستقبل للتوصيل"
                
            }else{
                alartmessage = "You cant add the same sender and receiver city"
                
            }
            let alert = UIAlertController(title:  ErrorHelper.shared.alartTitle, message:alartmessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:  ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            self.performSegue(withIdentifier: "toPayment2", sender: self)

        }
    }
    

    
    func apply2() {
        self.tableView?.reloadData()
    }
    
    func move() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let  AddAddressViewController = storyboard.instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
        let navInofrmationViewController = UINavigationController(rootViewController: AddAddressViewController)
        self.present(navInofrmationViewController, animated:true, completion: nil)
    }
    
    func apply(changes: SectionChanges) {
        self.tableView?.beginUpdates()
        
        self.tableView?.deleteSections(changes.deletes, with: .fade)
        self.tableView?.insertSections(changes.inserts, with: .fade)
        
        self.tableView?.reloadRows(at: changes.updates.reloads, with: .fade)
        self.tableView?.insertRows(at: changes.updates.inserts, with: .fade)
        self.tableView?.deleteRows(at: changes.updates.deletes, with: .fade)
        
        self.tableView?.endUpdates()
    }
    
    
}
