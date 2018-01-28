//
//  SettingsViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/18/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var IdentityLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        viewModel.delegate = self
        
        tableView?.dataSource = viewModel
        self.tableView.delegate = self.viewModel
        
        self.tableView?.estimatedRowHeight = 100
        self.tableView?.rowHeight = UITableViewAutomaticDimension
    
    
        self.tableView?.register(AddressSettingsTableViewCell.nib, forCellReuseIdentifier: AddressSettingsTableViewCell.identifier)
        self.tableView?.register(AddAddressTableViewCell.nib, forCellReuseIdentifier: AddAddressTableViewCell.identifier)
        viewModel.addListener()
        viewModel.addSlientData()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editImageAction(_ sender: Any) {
    }
    
    @IBAction func editDataAction(_ sender: Any) {
    }
    
    @IBAction func savePlayerDetail(_ segue: UIStoryboardSegue) {
        
        guard let AddAddressViewController = segue.source as? AddAddressViewController  else {
                return
        }
      viewModel.addListener()
    
    }
    @IBAction func cancelToPlayersViewController(_ segue: UIStoryboardSegue) {
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
extension SettingsViewController: ProfileViewModelDelegate {
    func finishLoadData() {
        nameLabel.text = DataClient.shared.profile?.name
        IdentityLabel.text = String((DataClient.shared.profile?.id!)!)
        phoneNumberLabel.text = DataClient.shared.profile?.phone
        mailLabel.text = DataClient.shared.profile?.email
        APIClient.sendImageRequest(path: (DataClient.shared.profile?.image)!, success: { (_ image) in
            self.imageView.image = image
        }, failure: { (_ error) in
            
        })
        
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
    
    func move(){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let  AddAddressViewController = storyboard.instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
                let navInofrmationViewController = UINavigationController(rootViewController: AddAddressViewController)
                self.present(navInofrmationViewController, animated:true, completion: nil)
    }
}
