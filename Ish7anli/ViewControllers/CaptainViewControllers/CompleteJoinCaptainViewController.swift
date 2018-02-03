//
//  CompleteJoinCaptainViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/26/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CompleteJoinCaptainViewController: UIViewController {
    
    @IBOutlet weak var accountNumberText: UITextField!
    let picker = UIImagePickerController()
    var pickedImagePath: URL?
    var pickedImageData: Data?
    var localPath: URL?
    var flag = 0
    var done = false
    var cardImage,licenceImage,carForm,contractImage:String?
    
   var fullname,
    cardNumber,
    mobile,
    email,
    password:String?
     var ok,error,alartTitle,loadingtitle,message:String?
    @IBOutlet weak var cardImageButton: UIButton!
    @IBOutlet weak var licenceImageButton: UIButton!
    @IBOutlet weak var carFormButton: UIButton!
    @IBOutlet weak var contractButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
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
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func joinAction(_ sender: Any) {
        if ((cardImage != nil) && (licenceImage != nil) && (carForm != nil) && (contractImage != nil) && !accountNumberText.text!.isEmpty ){
            self.performSegue(withIdentifier: "toCaptainType", sender: self)
        }else{
            if MOLHLanguage.isRTL() {
                self.error =  "يجب أن تقوم باختيار كافة الصور"
                self.ok = "موافق"
                self.alartTitle = "تنبيه"
            }else{
                self.error = "You should choose all the photo"
                self.ok = "Ok"
                self.alartTitle = "Alert"
                
            }
            let alert = UIAlertController(title: self.alartTitle, message:error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: self.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
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

extension CompleteJoinCaptainViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
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
