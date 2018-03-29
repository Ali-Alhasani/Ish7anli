//
//  ArchiveOrder.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/25/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation
class ArchiveOrder {

    var id:Int?
    var captainId:Int?
    var customerId:Int?
    var deliveryType:Int?
    var weight:Int?
    var receiverName:String?
    var receiverPhone:String?
    var paymentType:Int?
    var accountNumber:String?
    var amount:String?
    var time:String?
    var date:String?
    var status:Int?
    var captainOfferId:Int?
    var addressSenderTitle:String?
    var addressSenderDetails:String?
    var addressSenderLongitude:Double?
    var addressSenderLatitude:Double?
    var addressSenderCity:String?
    var addressReceiverTitle:String?
    var addressReceiverDetails:String?
    var addressReceiverLongitude:Double?
    var addressReceiverLatitude:Double?
    var addressReceiverCity:String?
    var customerName:String?
    var customerImage:String?
    var customerPhone:String?
    var customerEmail:String?
    var offerPrice:String?
    var offerRate:Double?
    var identity:String?
    
    
    
    init(json: [String: Any]) {
        self.id = json["id"] as? Int ?? 0
        self.captainId = json["captain_id"] as? Int ?? 0
        self.customerId = json["customer_id"] as? Int ?? 0
        self.deliveryType = json["delevary_type"] as? Int ?? 0
        self.weight = json["weight"] as? Int ?? 0
        self.receiverName = json["receiver_name"] as? String ?? ""
        self.receiverPhone = json["receiver_phone"] as? String ?? ""
        self.paymentType = json["payment_type"] as? Int ?? 0
        if let accountNumber = json["the_amount"] as? String {
             self.accountNumber = accountNumber
        }
        if let amount = json["the_amount"] as? String {
            self.amount = amount
        }
        self.time = json["time"] as? String ?? ""
        self.date = json["date"] as? String ?? ""
        self.status = json["stutas"] as? Int ?? 0
        self.captainOfferId = json["captain_offer_id"] as? Int ?? 0
        self.addressSenderTitle = json["address_sender_title"] as? String ?? ""
        self.addressSenderDetails = json["address_sender_details"] as? String ?? ""
        self.addressSenderLongitude = json["address_sender_longitude"] as? Double ?? 0.0
        self.addressSenderLatitude = json["address_sender_latitude"] as? Double ?? 0.0
        self.addressSenderCity = json["address_sender_city"] as? String ?? ""
        self.addressReceiverTitle = json["address_receiver_title"] as? String ?? ""
        self.addressReceiverDetails = json["address_receiver_details"] as? String ?? ""
        self.addressReceiverLongitude = json["address_receiver_longitude"] as? Double ?? 0.0
        self.addressReceiverLatitude = json["address_receiver_latitude"] as? Double ?? 0.0
        self.addressReceiverCity = json["address_receiver_city"] as? String ?? ""
        self.customerName = json["customer_name"] as? String ?? ""
        self.customerImage = json["customer_image"] as? String ?? ""
        self.customerPhone = json["customer_phone"] as? String ?? ""
        self.customerEmail = json["customer_email"] as? String ?? ""
        
        if let price = json["offer_price"] as? String  {
            self.offerPrice = price
        }else if let price = json["price"] as? String{
            self.offerPrice = price
        }else if let price = json["offer_price"] as? Int {
            self.offerPrice = String(price)
        }else if let price = json["price"] as? Int {
            self.offerPrice = String(price)
        }else {
            self.offerPrice = "0.0"
        }
      
        self.offerRate = json["offer_rate"] as? Double ?? 0.0
        if let identity = json["identity"] as? String  {
            self.identity = identity
        }else {
               self.identity = "0"
        }
    }
    init(){
        
    }
}
