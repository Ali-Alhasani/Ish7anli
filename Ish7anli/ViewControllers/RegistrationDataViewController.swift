//
//  RegistrationDataViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/1/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import FirebaseStorage
class RegistrationDataViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var fullNameText: UITextField!
    var imageStr:String?
    var image_data:UIImage?
    var statusEmail:Bool = false
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailText.delegate = self
        // Do any additional setup after loading the view.
        indicatorView.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editImageView(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType =  UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailText:
            statusEmail = isValidEmail(testStr: self.emailText.text!)
            
            if (statusEmail){
                //                    self.clinicEmailError.text = ""
                self.emailText.layer.borderWidth = 0
                
            }else{
                self.emailText.layer.borderWidth = 1
                self.emailText.layer.borderColor = UIColor.red.cgColor
                //                    self.clinicEmailError.text = "Must be a valid email address"
                
            }
            break
        default:
            print(textField.text!)
        }
        
        
    }
    func sendMedia(image: UIImage?){
         indicatorView.isHidden = false
        indicatorView.startAnimating()
        let refStorage = Storage.storage().reference().child("::\(Date().timeIntervalSince1970)")
        if let image = image {
            let data = UIImageJPEGRepresentation(image, 0.2)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            refStorage.putData(data!, metadata: metadata
                , completion: { (metadata, error) in
                    if error == nil{
                        guard let downloadUrl = metadata?.downloadURL() else {return}
                        self.imageStr = downloadUrl.absoluteString
                        self.indicatorView.stopAnimating()
                        self.indicatorView.isHidden = true
                        
                        
                    }else{
                        self.indicatorView.stopAnimating()
                        let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error?.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
            })
        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        if(emailText.text!.isEmpty || fullNameText.text!.isEmpty || imageStr == nil || statusEmail == false) {
            var error:String?
            if MOLHLanguage.isRTL() {
                error =  "يجب أن تقوم بإدخال كافة الحقول واختيار صورة شخصية"
                
            }else{
                error = "You should fill all the fields and pick a profile photo"
            }
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }else {
            let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
            
            
            spiningActivity.label.text = ErrorHelper.shared.loadingtitle
            spiningActivity.detailsLabel.text = ErrorHelper.shared.message
            load()
        }
    }
    
    
    //    func uplaodPhoto(_ photo:String){
    //        DataClient.shared.uploadProfilePhoto(success: {
    //            //self.imageView.image = self.image_data!
    //        }, failuer: { (_ error) in
    //
    //        }, photo: photo)
    //    }
    
    func load(){
        DataClient.shared.saveProfileCustomer(success: {
            MBProgressHUD.hide(for: self.view, animated: true)
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.move()
            //self.dismiss(animated: true, completion: nil)
        }, failuer: { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }, email: emailText.text!, name: fullNameText.text!, image: imageStr!)
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

extension RegistrationDataViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        image_data = info[UIImagePickerControllerOriginalImage] as? UIImage
        //let imageData = UIImagePNGRepresentation(image_data!)!
      
        //imageStr = imageData.base64EncodedString()
        self.imageView.image = self.image_data!
        sendMedia(image: image_data)
        // uplaodPhoto(imageStr!)
        self.dismiss(animated: true, completion: nil)
    }
}

