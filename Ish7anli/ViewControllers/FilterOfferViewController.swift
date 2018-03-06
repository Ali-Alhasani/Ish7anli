//
//  FilterOfferViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/21/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class FilterOfferViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var cityFromText: UITextField!
    @IBOutlet weak var cityToText: UITextField!


    var itemPicker: UIPickerView! = UIPickerView()
    var itemPicker2: UIPickerView! = UIPickerView()
    
    var senderId:Int?
    var recevierId:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         self.cityToText.delegate = self
         self.cityFromText.delegate = self
        
        load()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == itemPicker || pickerView == itemPicker2 ) {
            
            return DataClient.shared.allCity.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == itemPicker || pickerView == itemPicker2) {
            return DataClient.shared.allCity[row].name
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if (pickerView == itemPicker) {
            if(DataClient.shared.allCity.count > 0) {
                cityFromText.text = DataClient.shared.allCity[row].name
                senderId = DataClient.shared.allCity[row].id
            }
            
        }else if (pickerView == itemPicker2){
            if(DataClient.shared.allCity.count > 0) {
                cityToText.text = DataClient.shared.allCity[row].name
                recevierId = DataClient.shared.allCity[row].id
            }
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == cityFromText){
            self.itemPicker!.delegate = self
            self.itemPicker!.dataSource = self
            self.cityFromText.inputView = self.itemPicker
            
        }
        if (textField == cityToText){
            self.itemPicker2!.delegate = self
            self.itemPicker2!.dataSource = self
            self.cityToText.inputView = self.itemPicker2
        }
    }
    
    
    @IBAction func filterAction(_ sender: Any) {
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
        spiningActivity.label.text = ErrorHelper.shared.loadingtitle
        spiningActivity.detailsLabel.text = ErrorHelper.shared.message
        var parameters:Dictionary<String, Any> = [:]

        if (!(cityFromText.text?.isEmpty)!){
            parameters["city_id_to"] = senderId
        }
        if (!(cityToText.text?.isEmpty)!){
            parameters["city_id_from"] = recevierId
        }
        
        DataClient.shared.filter(success: {
               MBProgressHUD.hide(for: self.view, animated: true)
            self.performSegue(withIdentifier: "FilterDetails", sender: self)
        }, failuer: { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }, data: parameters)
  
        
        
    }
    
    func load(){
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        
        spiningActivity.label.text =  ErrorHelper.shared.loadingtitle
        spiningActivity.detailsLabel.text =  ErrorHelper.shared.message
        DataClient.shared.getCity(success: {
            MBProgressHUD.hide(for: self.view, animated: true)
            
        }) { (_ error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
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
