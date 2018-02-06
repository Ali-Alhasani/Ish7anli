//
//  CaptainSettingsViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/27/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CaptainSettingsViewController: UIViewController {
    
    @IBOutlet weak var accountNumberText: UITextField!
    let myPickerController = UIImagePickerController()
    var pickedImagePath: URL?
    var pickedImageData: Data?
    var localPath: URL?
    var flag = 0
    var done = false
    var cardImage,licenceImage,carForm,contractImage:String?
    @IBOutlet weak var cardImageButton: UIButton!
    @IBOutlet weak var licenceImageButton: UIButton!
    @IBOutlet weak var carFormButton: UIButton!
    @IBOutlet weak var contractButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountNumberText.setBottomBorder()
        myPickerController.delegate = self;
        myPickerController.sourceType =  UIImagePickerControllerSourceType.photoLibrary
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.hideBackButton()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addressAction(_ sender: Any) {
        
    }
    @IBAction func cardImageAction(_ sender: Any) {
        flag = 1
        self.present(myPickerController, animated: true,completion: nil)
        
    }
    
    @IBAction func licenceImageAction(_ sender: Any) {
        flag = 2
        self.present(myPickerController, animated: true,completion: nil)
        
    }
    
    @IBAction func carFormAction(_ sender: Any) {
        flag = 3
        self.present(myPickerController, animated: true,completion: nil)
        
    }
    
    @IBAction func contractAction(_ sender: Any) {
        flag = 4
        self.present(myPickerController, animated: true,completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func unwindFromAddVC22(_ sender: UIStoryboardSegue){
        
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        var parameters:Dictionary<String, Any> = [:]
        if (cardImage != nil){
            parameters["card_image"] = cardImage!
         
        }
        if (licenceImage != nil){
            parameters["license_image"] = licenceImage!
         
        }
        if (carForm != nil){
            parameters["car_form"] = carForm!
          
        }
        if (contractImage != nil){
            parameters["contract_image"] = contractImage!
          
        }
          parameters["financial_account_number"] = accountNumberText.text!
        
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        
   
        spiningActivity.label.text = ErrorHelper.shared.loadingtitle
        spiningActivity.detailsLabel.text = ErrorHelper.shared.message
        
        
        DataClient.shared.updateCaptainProfile(success: {
            MBProgressHUD.hide(for: self.view, animated: true)
            
                var alartmessage:String?
            if MOLHLanguage.isRTL() {
                alartmessage = "تم تعديل الملف الشخصي بنجاح"
                
            }else{
                alartmessage = "the profile has been edited successfully"
                
            }
            let alert = UIAlertController(title:  ErrorHelper.shared.alartTitle, message:alartmessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:  ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
            

        }, failuer: { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
            
            
        }, parameters: parameters)
//
//        DataClient.shared.updateCaptainProfile(success: {
//
//        }, failuer: { () in
//
//        }, photo: <#T##String#>)
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
extension CaptainSettingsViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        done = false
        let image_data = info[UIImagePickerControllerOriginalImage] as? UIImage
        //let imageData = UIImagePNGRepresentation(image_data!)!
        let imageData:Data = image_data!.compressTo(1)!
        let imageStr = imageData.base64EncodedString()
        if (flag == 1) {
            print("Hi")
            cardImage = imageStr
            self.cardImageButton.setImage(UIImage(named: "checked"), for: UIControlState.normal)
            
        }else if (flag == 2) {
            licenceImage = imageStr
            self.licenceImageButton.setImage(UIImage(named: "checked"), for: UIControlState.normal)
        }else if (flag == 3){
            carForm = imageStr
            self.carFormButton.setImage(UIImage(named: "checked"), for: UIControlState.normal)
            
        }else if (flag == 4) {
            contractImage = imageStr
            self.contractButton.setImage(UIImage(named: "checked"), for: UIControlState.normal)
            
        }
        //success(imageStr)
        //uplaodPhoto(imageStr)
        self.dismiss(animated: true) {
            self.done = true
        }
        // self.dismiss(animated: true, completion: nil)
    }
}


