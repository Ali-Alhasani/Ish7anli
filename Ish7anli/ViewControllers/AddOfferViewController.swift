//
//  AddOfferViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/17/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class AddOfferViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel = OfferAddressViewModel()
    var senderAddress:Int?
    var receiveAddress:Int?
    var weghitIndex:Int?
    var receiverName:String?
    var receiverPhone:String?
    var captainOfferId:Int?
    var senderName:String?
    var recevierName:String?
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

        //sender = senderName
        //receiver = recevierName
        
        viewModel.addListener()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.setNavigationBarItem()
        self.hideBackButton()
        viewModel.addListener()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func savePlayerDetail(_ segue: UIStoryboardSegue) {
        
        guard let AddAddressViewController = segue.source as? AddAddressViewController  else {
            return
        }
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
        if segue.identifier == "toPayment" {
            
            let vc = segue.destination as! PaymentMethodViewController
            vc.senderAddress = senderAddress!
            vc.receiveAddress = receiveAddress!
            vc.weghitIndex = weghitIndex!
            vc.receiverName = receiverName!
            vc.receiverPhone = receiverPhone!
            vc.captainOfferId = captainOfferId!
        }
    }


}
extension AddOfferViewController: OfferAddressViewModelDelegate {
    func presentError(_ error: String) {
        let alert = UIAlertController(title:  ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:  ErrorHelper.shared.ok, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func move2(_ senderAddress: Int, _ receiveAddress: Int, weghitIndex: Int, information: [Int]) {
        self.senderAddress = senderAddress
          self.receiveAddress = receiveAddress
         self.weghitIndex = weghitIndex
        
        let multilineCell = tableView.cellForRow(at: IndexPath(row: information.first!, section: 4)) as? TextViewTableViewCell
          let multilineCell2 = tableView.cellForRow(at: IndexPath(row: information.last!, section: 4)) as? TextViewTableViewCell
           // (index: ))
        //cellForRow(at: ) as? TextViewTableViewCell // we cast here so that you can access your custom property.
      self.receiverName =   multilineCell!.textView.text!
          self.receiverPhone = multilineCell2!.textView.text!
    

        self.performSegue(withIdentifier: "toPayment", sender: self)
    }
    
 
    
    func apply2() {
        self.tableView?.reloadData()
    }
    
    func move() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let  AddAddressViewController = storyboard.instantiateViewController(withIdentifier: "CaptainAddAddressViewController") as! CaptainAddAddressViewController
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
