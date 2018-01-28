//
//  CaptainAddOfferViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/28/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CaptainAddOfferViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource  {

    @IBOutlet weak var cityFromText: UITextField!
    @IBOutlet weak var DateFromText: UITextField!
    @IBOutlet weak var hourFromText: UITextField!
    @IBOutlet weak var CityToText: UITextField!
    @IBOutlet weak var DateToText: UITextField!
    @IBOutlet weak var hourToText: UITextField!
    
    @IBOutlet weak var accountNumberText: UITextField!
    
    var itemPicker: UIPickerView! = UIPickerView()
    var itemPicker2: UIPickerView! = UIPickerView()
    var tmp:Int?
    var tmp2:Int?
    var indexPath:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.CityToText.delegate = self
        self.cityFromText.delegate = self
        load()
        // Do any additional setup after loading the view.
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
                tmp = DataClient.shared.allCity[row].id
            }
            
        }else if (pickerView == itemPicker2){
            if(DataClient.shared.allCity.count > 0) {
                CityToText.text = DataClient.shared.allCity[row].name
                tmp2 = DataClient.shared.allCity[row].id
            }
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == cityFromText){
            self.itemPicker!.delegate = self
            self.itemPicker!.dataSource = self
            self.cityFromText.inputView = self.itemPicker
            
        }
        if (textField == CityToText){
            self.itemPicker2!.delegate = self
            self.itemPicker2!.dataSource = self
            self.CityToText.inputView = self.itemPicker2
        }
        
    }

    @IBAction func addAction(_ sender: Any) {
        DataClient.shared.captainAddOffer(success: {
            
        }, failuer: { (_ error) in
            
        }, cityIdFrom: tmp!, goDate: DateFromText.text!, goTime: hourFromText.text!, cityIdTo: tmp2!, arrivalDate: DateToText.text!, arrivalTime: hourToText.text!, price: accountNumberText.text!)
    }
    
    func load(){
        DataClient.shared.getCity(success: {
            
        }) { (_ error) in
            print(error)
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
