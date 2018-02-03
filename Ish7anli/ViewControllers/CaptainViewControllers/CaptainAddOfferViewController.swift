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
    
    @IBOutlet weak var scrollView: UIScrollView!
    var itemPicker: UIPickerView! = UIPickerView()
    var itemPicker2: UIPickerView! = UIPickerView()
    
    var DatePicker: UIPickerView! = UIPickerView()
    var DatePicker2: UIPickerView! = UIPickerView()
    
    var timePicker: UIPickerView! = UIPickerView()
    var timePicker2: UIPickerView! = UIPickerView()
    var tmp:Int?
    var tmp2:Int?
    var indexPath:Int?
    var ok,error,alartTitle,loadingtitle,message:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        self.view.backgroundColor = UIColor(rgb: 0xf7f7f7)
        
        self.CityToText.delegate = self
        self.cityFromText.delegate = self
        self.DateFromText.delegate = self
        self.DateToText.delegate = self
        self.hourFromText.delegate = self
        self.hourToText.delegate = self
        load()
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false

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
        if(textField == DateFromText){
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = UIDatePickerMode.date
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(self.datePickerchanged(sender:)), for: .valueChanged)
        }
        if(textField == DateToText){
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = UIDatePickerMode.date
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(self.datePickerchanged2(sender:)), for: .valueChanged)
        }
        if(textField == hourFromText){
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = UIDatePickerMode.time
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(self.startTimeDiveChanged), for: .valueChanged)

           // hourToText.text = datePicker.date
           // datePicker.addTarget(self, action: #selector(self.datePickerchanged(sender:)), for: .valueChanged)
        }
        if(textField == hourToText){
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = UIDatePickerMode.time
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(self.endTimeDiveChanged), for: .valueChanged)

            //datePicker.addTarget(self, action: #selector(self.datePickerchanged2(sender:)), for: .valueChanged)
        }
        
    }
    @objc func datePickerchanged(sender: UIDatePicker) {
        DateFromText.text = format().string(from: sender.date)
    }
    @objc func datePickerchanged2(sender: UIDatePicker) {
        DateToText.text = format().string(from: sender.date)
    }
   @objc func startTimeDiveChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        hourFromText.text = formatter.string(from: sender.date)
    }
    @objc func endTimeDiveChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        hourToText.text = formatter.string(from: sender.date)
    }
    
    func format() -> DateFormatter{
        let format = DateFormatter()
        format.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        format.dateFormat = "yyyy-MM-dd"
        return format
    }
    
    
    

    @IBAction func addAction(_ sender: Any) {
        DataClient.shared.captainAddOffer(success: {
            
        }, failuer: { (_ error) in
            let alert = UIAlertController(title: self.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: self.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }, cityIdFrom: tmp!, goDate: DateFromText.text!, goTime: hourFromText.text!, cityIdTo: tmp2!, arrivalDate: DateToText.text!, arrivalTime: hourToText.text!, price: accountNumberText.text!)
    }
    
    func load(){
        DataClient.shared.getCity(success: {
            
        }) { (_ error) in
            let alert = UIAlertController(title: self.alartTitle, message:error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: self.ok, style: .default, handler: nil))
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
