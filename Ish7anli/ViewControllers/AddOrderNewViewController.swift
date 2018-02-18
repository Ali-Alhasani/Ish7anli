//
//  AddOrderNewViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/19/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class AddOrderNewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = AddressViewModel()
    var senderAddress,weghitIndex,deliveryIndex:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        //load()
        
        viewModel.delegate = self
        
        tableView?.dataSource = viewModel
        self.tableView.delegate = self.viewModel
        
        self.tableView?.estimatedRowHeight = 100
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        
        
        self.tableView?.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
        self.tableView?.register(AddAddressTableViewCell.nib, forCellReuseIdentifier: AddAddressTableViewCell.identifier)
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
        if segue.identifier == "toSecond" {
            
            let vc = segue.destination as! AddOrder2ViewController
            vc.senderAddress = senderAddress!
            vc.weghitIndex = weghitIndex!
            vc.deliveryIndex = deliveryIndex!
        }
    }
    @IBAction func savePlayerDetail(_ segue: UIStoryboardSegue) {
        
        guard let AddAddressViewController = segue.source as? AddAddressViewController  else {
            return
        }
        viewModel.addListener()
        
    }
    

}
extension AddOrderNewViewController: AddressViewModelDelegate {
    func errorNoSelected() {
        var error:String?
        if MOLHLanguage.isRTL() {
            error = "يجب أن تقوم بإضافة عنوان المرسل"
            
        }else{
            error = "You should add a valid sender address"
            
        }
        let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func move2(_ senderAddress: Int, _ deliveryIndex: Int, weghitIndex: Int) {
          self.senderAddress = senderAddress
          self.deliveryIndex = deliveryIndex
           self.weghitIndex = weghitIndex
          self.performSegue(withIdentifier: "toSecond", sender: self)
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

