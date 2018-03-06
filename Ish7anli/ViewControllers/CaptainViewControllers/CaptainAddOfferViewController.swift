//
//  CaptainAddOfferViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/28/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import UIKit

class CaptainAddOfferViewController: UIViewController,UITextFieldDelegate {
    
    //@IBOutlet weak var cityFromText: UITextField!
    @IBOutlet weak var DateFromText: UITextField!
    @IBOutlet weak var hourFromText: UITextField!
    //@IBOutlet weak var CityToText: UITextField!
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
    var viewModel = AddOfferViewModel()
    var viewModel2 = AddOffer2ViewModel()
    var senderId:Int?
    var recevierId:Int?
    
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var secondTableView: UITableView!
    @IBOutlet weak var tableViewHight: NSLayoutConstraint!
    // var ok,error,alartTitle,loadingtitle,message:String?
    @IBOutlet weak var secondTableViewHeight: NSLayoutConstraint!
    
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
        
       // self.CityToText.delegate = self
        //self.cityFromText.delegate = self
        self.DateFromText.delegate = self
        self.DateToText.delegate = self
        self.hourFromText.delegate = self
        self.hourToText.delegate = self
        
        
        
        load()
        
        viewModel.delegate = self
        
        firstTableView?.dataSource = viewModel
        self.firstTableView.delegate = self.viewModel
        
        self.firstTableView?.estimatedRowHeight = 70
        self.firstTableView?.rowHeight = UITableViewAutomaticDimension
        
        
        self.firstTableView?.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
        self.firstTableView?.register(AddAddressTableViewCell.nib, forCellReuseIdentifier: AddAddressTableViewCell.identifier)
        
        
        
        viewModel.addListener()
        
        viewModel2.delegate = self
        
        secondTableView?.dataSource = viewModel2
        self.secondTableView.delegate = self.viewModel2
        
        self.secondTableView?.estimatedRowHeight = 70
        self.secondTableView?.rowHeight = UITableViewAutomaticDimension
        
        
        self.secondTableView?.register(ListTableViewCell.nib, forCellReuseIdentifier: ListTableViewCell.identifier)
        self.secondTableView?.register(AddAddressTableViewCell.nib, forCellReuseIdentifier: AddAddressTableViewCell.identifier)
        
        
        
        viewModel2.addListener()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        viewModel.addListener()
        viewModel2.addListener()
        
    }
    //    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    //        return 1
    //
    //    }
    //
    //    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    //        if (pickerView == itemPicker || pickerView == itemPicker2 ) {
    //
    //            return DataClient.shared.allCity.count
    //        }
    //        return 0
    //    }
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        if (pickerView == itemPicker || pickerView == itemPicker2) {
    //            return DataClient.shared.allCity[row].name
    //        }
    //        return ""
    //    }
    //
    //    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    //    {
    //        if (pickerView == itemPicker) {
    //            if(DataClient.shared.allCity.count > 0) {
    //                cityFromText.text = DataClient.shared.allCity[row].name
    //                tmp = DataClient.shared.allCity[row].id
    //            }
    //
    //        }else if (pickerView == itemPicker2){
    //            if(DataClient.shared.allCity.count > 0) {
    //                CityToText.text = DataClient.shared.allCity[row].name
    //                tmp2 = DataClient.shared.allCity[row].id
    //            }
    //        }
    //    }
    //
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //
        //        if(textField == cityFromText){
        //            self.itemPicker!.delegate = self
        //            self.itemPicker!.dataSource = self
        //            self.cityFromText.inputView = self.itemPicker
        //
        //        }
        //        if (textField == CityToText){
        //            self.itemPicker2!.delegate = self
        //            self.itemPicker2!.dataSource = self
        //            self.CityToText.inputView = self.itemPicker2
        //        }
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
        
        if ( DateFromText.text!.isEmpty || hourFromText.text!.isEmpty || DateToText.text!.isEmpty || hourToText.text!.isEmpty || accountNumberText.text!.isEmpty || senderId == nil || recevierId == nil){
            var error:String?
            if MOLHLanguage.isRTL() {
                error =  "يجب أن تقوم بإدخال كافة الحقول"
                
            }else{
                error = "You should fill all the fields"
            }
            let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            
            if (senderId == recevierId || tmp == tmp2) {
                var error:String?
                if MOLHLanguage.isRTL() {
                    error =  "لا يمكنك اختيار نفس العنوان أو نفس المدينة عند إضافة عرض الجديد"
                    
                }else{
                    error = "You cant choose the same address or the same city"
                }
                let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
                self.present(alert, animated: true)
            }else{
                let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
                
                
                spiningActivity.label.text = ErrorHelper.shared.loadingtitle
                spiningActivity.detailsLabel.text = ErrorHelper.shared.message
                
                DataClient.shared.captainAddOffer(success: {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    var alartmessage:String?
                    if MOLHLanguage.isRTL() {
                        alartmessage = "تم اضافة الطلب بنجاح"
                        
                    }else{
                        alartmessage = "the request has been added successfully"
                        
                    }
                    let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:alartmessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: self.someHandler))
                    self.present(alert, animated: true)
                    
                }, failuer: { (_ error) in
                    let alert = UIAlertController(title: ErrorHelper.shared.alartTitle, message:error.message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ErrorHelper.shared.ok, style: .default, handler: nil))
                    self.present(alert, animated: true)
                }, cityIdFrom: tmp!, goDate: DateFromText.text!, goTime: hourFromText.text!, cityIdTo: tmp2!, arrivalDate: DateToText.text!, arrivalTime: hourToText.text!, price: accountNumberText.text!, address_receiver_id: recevierId!, address_sender_id: senderId! )
            }
        }
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
    func someHandler(alert: UIAlertAction!) {
        self.performSegue(withIdentifier: "unwindFromAddVC3", sender: self)
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
extension CaptainAddOfferViewController: AddOfferViewModelDelegate,AddOffer2ViewModelDelegate {
    
    
    func apply1(changes: SectionChanges) {
        self.secondTableView?.beginUpdates()
        self.secondTableView?.deleteSections(changes.deletes, with: .fade)
        self.secondTableView?.insertSections(changes.inserts, with: .fade)
        self.secondTableView?.reloadRows(at: changes.updates.reloads, with: .fade)
        self.secondTableView?.insertRows(at: changes.updates.inserts, with: .fade)
        self.secondTableView?.deleteRows(at: changes.updates.deletes, with: .fade)
        secondTableViewHeight.constant = secondTableView.contentSize.height - 10
        self.secondTableView?.endUpdates()
        
        // self.secondTableView?.hight =
    }
    
    
    func apply(changes: SectionChanges) {
        self.firstTableView?.beginUpdates()
        
        self.firstTableView?.deleteSections(changes.deletes, with: .fade)
        self.firstTableView?.insertSections(changes.inserts, with: .fade)
        
        self.firstTableView?.reloadRows(at: changes.updates.reloads, with: .fade)
        self.firstTableView?.insertRows(at: changes.updates.inserts, with: .fade)
        self.firstTableView?.deleteRows(at: changes.updates.deletes, with: .fade)
        tableViewHight.constant = firstTableView.contentSize.height - 10
        
        self.firstTableView?.endUpdates()
        
        
    }
    
    
    func move() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let  AddAddressViewController = storyboard.instantiateViewController(withIdentifier: "CaptainAddAddressViewController") as! CaptainAddAddressViewController
        let navInofrmationViewController = UINavigationController(rootViewController: AddAddressViewController)
        self.present(navInofrmationViewController, animated:true, completion: nil)
    }
    func apply2(senderId: Int, cityId:Int) {
        self.senderId = senderId
        self.tmp = cityId
        self.firstTableView?.reloadData()
    }
    
    
    func apply3(reciverId:Int, cityId:Int) {
        self.recevierId = reciverId
        self.tmp2 = cityId
        self.secondTableView?.reloadData()
    }
    
    
}

