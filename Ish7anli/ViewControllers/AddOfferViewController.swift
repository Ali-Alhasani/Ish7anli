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
    var senderAddress:String?
    var receiveAddress:String?
    var weghitIndex:Int?
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
        }
    }


}
extension AddOfferViewController: OfferAddressViewModelDelegate {
    func move2(_ senderAddress: String, _ receiveAddress: String, weghitIndex: Int) {
        self.senderAddress = senderAddress
          self.receiveAddress = receiveAddress
         self.weghitIndex = weghitIndex
        self.performSegue(withIdentifier: "toPayment", sender: self)
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
