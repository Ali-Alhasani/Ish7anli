//
//  SettingsViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/18/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import PopupDialog
class SettingsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var IdentityLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var firstButton: RadioButton!
    @IBOutlet weak var secondButton: RadioButton!
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = ProfileViewModel()
    var ok:String?
    var message:String?
    var Alert:String?
    var image_data:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstButton.alternateButton = [secondButton]
        secondButton.alternateButton = [firstButton]
        if MOLHLanguage.isRTL() {
            secondButton.isSelected = true
        }else {
            firstButton.isSelected = true
        }
        viewModel.delegate = self
        
        tableView?.dataSource = viewModel
        self.tableView.delegate = self.viewModel
        
        self.tableView?.estimatedRowHeight = 100
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        
        
        self.tableView?.register(AddressSettingsTableViewCell.nib, forCellReuseIdentifier: AddressSettingsTableViewCell.identifier)
        self.tableView?.register(AddAddressTableViewCell.nib, forCellReuseIdentifier: AddAddressTableViewCell.identifier)
        viewModel.addListener()
        viewModel.addSlientData()
        
      
        if MOLHLanguage.isRTL() {
          
            message = "The app needs to reboot for a language change to take the full effect, please close and open the app again to see the effect, thanks!"
            Alert = "Alert"
            ok = "OK"
        }else{
            message =  "يحتاج التطبيق إلى إعادة تشغيل لضمان تطبيق التأثير الكامل لتغيير اللغة، الرجاء إغلاق وفتح التطبيق مرة أخرى، شكراً!"
            Alert = "تنبيه"
            ok = "موافق"
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
    
    @IBAction func editImageAction(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType =  UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    @IBAction func editDataAction(_ sender: Any) {
        showCustomDialog()
    }
    
    @IBAction func savePlayerDetail(_ segue: UIStoryboardSegue) {
        
        guard let AddAddressViewController = segue.source as? AddAddressViewController  else {
            return
        }
        viewModel.addListener()
        
    }
    @IBAction func cancelToPlayersViewController(_ segue: UIStoryboardSegue) {
    }
    
    func uplaodPhoto(_ photo:String){
        DataClient.shared.uploadProfilePhoto(success: {
            self.imageView.image = self.image_data
        }, failuer: { (_ error) in
          
        }, photo: photo)
    }
    
    
    func showCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let ratingVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: ratingVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)

        
        // Add buttons to dialog
        //popup.addButtons([buttonOne, buttonTwo])
         viewModel.addSlientData()
        // Present dialog
        present(popup, animated: animated, completion: nil)
    }
    
    
    @IBAction func EnglishButtonAction(_ sender: Any) {
      //firstButton.isSelected = true
          // secondButton.isSelected = false
        MOLH.setLanguageTo("en")
        let alert = UIAlertController(title: Alert, message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
        MOLH.reset()

    }
    
    
    @IBAction func ArabicButtonAction(_ sender: Any) {
        //secondButton.isSelected = true
        //firstButton.isSelected = false
        MOLH.setLanguageTo("ar")
        let alert = UIAlertController(title: Alert, message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
        MOLH.reset()
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
        // IdentityLabel.text = String((DataClient.shared.profile?.id!)!)
        phoneNumberLabel.text = DataClient.shared.profile?.phone
        mailLabel.text = DataClient.shared.profile?.email
        APIClient.sendImageRequest(path: (DataClient.shared.profile?.image)!, success: { (_ image) in
            self.imageView.image = image
        }, failure: { (_ error) in
            let alert = UIAlertController(title: alartTitle, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: self.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
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

extension SettingsViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
         image_data = info[UIImagePickerControllerOriginalImage] as? UIImage
        //let imageData = UIImagePNGRepresentation(image_data!)!
        let imageData:Data = image_data!.compressTo(1)!
        let imageStr = imageData.base64EncodedString()
        uplaodPhoto(imageStr)
        self.dismiss(animated: true, completion: nil)
    }
}
