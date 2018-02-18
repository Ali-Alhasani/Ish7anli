//
//  CompleteJoinCaptainViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/26/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit
import FirebaseStorage
enum ImageType {
    case cardImage
    case captainImage
    case licenceImage
    case carForm
    case contract
}
class CompleteJoinCaptainViewController: UIViewController {
    
    @IBOutlet weak var accountNumberText: UITextField!
    let picker = UIImagePickerController()
    var pickedImagePath: URL?
    var pickedImageData: Data?
    var localPath: URL?
    var flag = 0
    var counter = 0
    var done = false
    var cardImage,licenceImage,carForm,contractImage,captainImage:String?
    
    var fullname,
    cardNumber,
    mobile,
    email,
    password:String?
    
    var lat,lng:Double?
    var name,details:String?
    @IBOutlet weak var cardImageButton: UIButton!
    @IBOutlet weak var licenceImageButton: UIButton!
    @IBOutlet weak var carFormButton: UIButton!
    @IBOutlet weak var contractButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var captainImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        self.view.backgroundColor = UIColor(rgb: 0xf7f7f7)
        
        
        // Do any additional setup after loading the view.
        
        picker.allowsEditing = false
        picker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cardImageAction(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType =  UIImagePickerControllerSourceType.photoLibrary
        flag = 1
        self.present(myPickerController, animated: true,completion: nil)
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackButton2()
    }
    
    
    @IBAction func licenceImageAction(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType =  UIImagePickerControllerSourceType.photoLibrary
        flag = 2
        self.present(myPickerController, animated: true,completion: nil)
        
        
        
    }
    
    @IBAction func carFormAction(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType =  UIImagePickerControllerSourceType.photoLibrary
        flag = 3
        self.present(myPickerController, animated: true,completion: nil)
        
        
    }
    
    @IBAction func contractAction(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType =  UIImagePickerControllerSourceType.photoLibrary
        flag = 4
        self.present(myPickerController, animated: true,completion: nil)
        
    }
    
    @IBAction func captainImageAction(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType =  UIImagePickerControllerSourceType.photoLibrary
        flag = 5
        self.present(myPickerController, animated: true,completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sendMedia(image: UIImage?,type:ImageType){
        let refStorage = Storage.storage().reference().child("::\(Date().timeIntervalSince1970)")
        if let image = image {
            let data = UIImageJPEGRepresentation(image, 0.2)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            refStorage.putData(data!, metadata: metadata
                , completion: { (metadata, error) in
                    if error == nil{
                        guard let downloadUrl = metadata?.downloadURL() else {return}
                        
                        switch type{
                        case .cardImage:
                            self.cardImage = downloadUrl.absoluteString
                            self.cardImageButton.setImage(UIImage(named: "checked"), for: UIControlState.normal)
                            
                        case .carForm:
                            self.carForm = downloadUrl.absoluteString
                            self.carFormButton.setImage(UIImage(named: "checked"), for: UIControlState.normal)
                        case .contract:
                            self.contractImage = downloadUrl.absoluteString
                            self.contractButton.setImage(UIImage(named: "checked"), for: UIControlState.normal)
                        case .licenceImage:
                            self.licenceImage =  downloadUrl.absoluteString
                            self.licenceImageButton.setImage(UIImage(named: "checked"), for: UIControlState.normal)
                            
                        case .captainImage:
                            self.captainImage = downloadUrl.absoluteString
                            self.captainImageButton.setImage(UIImage(named: "checked"), for: UIControlState.normal)
                            
                        }
                    }else{
                        let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error?.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
            })
        }
    }
    
    
    
    @IBAction func joinAction(_ sender: Any) {
        if ((cardImage != nil) && (licenceImage != nil) && (carForm != nil) && (contractImage != nil) && (captainImage != nil) && !accountNumberText.text!.isEmpty ){
            self.performSegue(withIdentifier: "toCaptainType", sender: self)
            //            if (counter != 3){
            //                var error:String?
            //                let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
            //
            //                spiningActivity.label.text = ErrorHelper.shared.loadingtitle
            //                spiningActivity.detailsLabel.text = ErrorHelper.shared.message
            //                //                if MOLHLanguage.isRTL() {
            //                //                    error =  "انتظر حتى يتم رفع جميع الصور"
            //                //                }else{
            //                //                    error = "Wait until upload all the photos"
            //                //                }
            //                //                let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
            //                //                alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            //                //                self.present(alert, animated: true)
            //            }else{
            //                self.performSegue(withIdentifier: "toCaptainType", sender: self)
            //            }
        }else{
            var error:String?
            if MOLHLanguage.isRTL() {
                error =  "يجب أن تقوم باختيار كافة الصور"
            }else{
                error = "You should choose all the photo"
            }
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    @IBAction func dismisAddress(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func savePlayerDetail(_ segue: UIStoryboardSegue) {
        
        guard let CaptainRegisterAddAddressViewController = segue.source as? CaptainRegisterAddAddressViewController  else {
            return
        }
        
        self.lat =  CaptainRegisterAddAddressViewController.lat
        self.lng =  CaptainRegisterAddAddressViewController.lng
        self.name = CaptainRegisterAddAddressViewController.name
        self.details = CaptainRegisterAddAddressViewController.details
        
        //viewModel.addListener()
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCaptainType" {
            let vc = segue.destination as! CaptianTypeViewController
            
            vc.fullname = fullname!
            vc.cardNumber = cardNumber!
            vc.mobile = mobile!
            vc.email = email!
            vc.password = password!
            vc.accountNumber = accountNumberText.text!
            vc.cardImage = cardImage!
            vc.licenceImage = licenceImage!
            vc.carForm = carForm!
            vc.contractImage = contractImage!
            vc.captainImage = captainImage!
            vc.tilte = name!
            vc.details = details!
            vc.lng = lng!
            vc.lat = lat!
            
            
        }
        
        
    }
    //    func uplaodPhoto(_ photo:Dictionary<String, String>){
    //        DataClient.shared.uploadCaptainPhotos(success: {
    //            self.counter += 1
    //            if (self.counter == 3){
    //                MBProgressHUD.hide(for: self.view, animated: true)
    //            }
    //        }, failuer: { (_ error) in
    //            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
    //            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
    //            self.present(alert, animated: true)
    //        }, parameters: photo)
    //        //self.imageView.image = self.image_data!
    //
    //    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension CompleteJoinCaptainViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        done = false
        let image_data = info[UIImagePickerControllerOriginalImage] as? UIImage
        //let imageData = UIImagePNGRepresentation(image_data!)!
        //        let imageData:UIImage = image_data!.compressToHalf(2)!
        //       /let imageStr = imageData.base64EncodedString()
        if (flag == 1) {
            print("Hi")
            // cardImage = imageStr
            // uplaodPhoto(["card_image": cardImage!])
            sendMedia(image: image_data, type: .cardImage)
            
            
        }else if (flag == 2) {
            sendMedia(image: image_data, type: .licenceImage)
        }else if (flag == 3){
            sendMedia(image: image_data, type: .carForm)
            //            carForm = imageStr
            //            //uplaodPhoto(["car_form": carForm!])
            //            self.carFormButton.setImage(UIImage(named: "checked"), for: UIControlState.normal)
            
        }else if (flag == 4) {
            sendMedia(image: image_data, type: .contract)
            //            contractImage = imageStr
            //           // uplaodPhoto(["contract_image": contractImage!])
            //            self.contractButton.setImage(UIImage(named: "checked"), for: UIControlState.normal)
            
        }else if (flag == 5){
            sendMedia(image: image_data, type: .captainImage)
        }
        //success(imageStr)
        //uplaodPhoto(imageStr)
        self.dismiss(animated: true) {
            self.done = true
        }
        // self.dismiss(animated: true, completion: nil)
    }
}
