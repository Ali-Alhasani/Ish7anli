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
    let picker = UIImagePickerController()
    var pickedImagePath: URL?
    var pickedImageData: Data?
    var localPath: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        accountNumberText.setBottomBorder()
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
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func licenceImageAction(_ sender: Any) {
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func carFormAction(_ sender: Any) {
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func contractAction(_ sender: Any) {
        present(picker, animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
extension CaptainSettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        //imgView.image = image
        
        let documentDirectory: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let imageName = "temp"
        let imagePath = NSURL(fileURLWithPath: documentDirectory).appendingPathComponent(imageName)
        // let imagePath = photoURL.appendingPathComponent(imageName)
        
        //        if let data = UIImageJPEGRepresentation(image, 80) {
        //            data.write(to: imagePath)
        //            //writeToFile(imagePath, atomically: true)
        //        }
        if let data = UIImageJPEGRepresentation(image, 80) {
            do {
                try data.write(to: imagePath!, options: .atomic)
            } catch {
                print(error)
            }
        }
        
        localPath = imagePath
        
        dismiss(animated: true, completion: {
            print("done")
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


