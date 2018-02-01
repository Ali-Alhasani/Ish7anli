//
//  RegistrationDataViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/1/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class RegistrationDataViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var fullNameText: UITextField!
    var imageStr:String?
    var image_data:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func saveButton(_ sender: Any) {
        if(emailText.text!.isEmpty || fullNameText.text!.isEmpty || imageStr == nil ) {
            
        }else {
          load()
        }
    }
    
    
    func uplaodPhoto(_ photo:String){
        DataClient.shared.uploadProfilePhoto(success: {
            self.imageView.image = self.image_data!
        }, failuer: { (_ error) in
           
        }, photo: photo)
    }
    
    func load(){
        DataClient.shared.saveProfileCustomer(success: {
            print("success")
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.move()
            //self.dismiss(animated: true, completion: nil)
        }, failuer: { (_ error) in
            print(error)
        }, email: emailText.text!, name: fullNameText.text!)
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
        let imageData:Data = image_data!.compressTo(1)!
        imageStr = imageData.base64EncodedString()
        uplaodPhoto(imageStr!)
        self.dismiss(animated: true, completion: nil)
    }
}

