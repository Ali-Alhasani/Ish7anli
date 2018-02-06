//
//  CustomerOffer.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/25/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation
class CustomerOffer {
    
    var id:Int?
    var captainId:Int?
    var customerId:Int?
    var deliveryType:Int?
    var weight:Int?
    var receiverName:String?
    var receiverPhone:String?
    var paymentType:String?
    var accountNumber:String?
    var amount:String?
    var time:String?
    var date:String?
    var status:String?
    var captainOfferId:Int?
    var addressSenderTitle:String?
    var addressSenderDetails:String?
    var addressSenderLongitude:String?
    var addressSenderLatitude:String?
    var addressSenderCity:String?
    var addressReceiverTitle:String?
    var addressReceiverDetails:String?
    var addressReceiverLongitude:String?
    var addressReceiverLatitude:String?
    var addressReceiverCity:String?
    var bid = [Bid]()

   
    init(json: [String: Any]) {
        self.id = json["id"] as? Int ?? 0
        self.captainId = json["captain_id"] as? Int ?? 0
        self.customerId = json["customer_id"] as? Int ?? 0
        self.deliveryType = json["delevary_type"] as? Int ?? 0
        self.weight = json["weight"] as? Int ?? 0
        self.receiverName = json["receiver_name"] as? String ?? ""
        self.receiverPhone = json["receiver_phone"] as? String ?? ""
        self.paymentType = json["payment_type"] as? String ?? ""
        self.accountNumber = json["account_number"] as? String ?? ""
        self.amount = json["the_amount"] as? String ?? ""
        self.time = json["time"] as? String ?? ""
        self.date = json["date"] as? String ?? ""
        self.status = json["stutas"] as? String ?? ""
        
        self.captainOfferId = json["captain_offer_id"] as? Int ?? 0
        self.addressSenderTitle = json["address_sender_title"] as? String ?? ""
        self.addressSenderDetails = json["address_sender_details"] as? String ?? ""
        self.addressSenderLongitude = json["address_sender_longitude"] as? String ?? ""
        self.addressSenderLatitude = json["address_sender_latitude"] as? String ?? ""
        self.addressSenderCity = json["address_sender_city"] as? String ?? ""
        self.addressReceiverTitle = json["address_receiver_title"] as? String ?? ""
        self.addressReceiverDetails = json["address_receiver_details"] as? String ?? ""
        self.addressReceiverLongitude = json["address_receiver_longitude"] as? String ?? ""
        self.addressReceiverLatitude = json["address_receiver_latitude"] as? String ?? ""
        self.addressReceiverCity = json["address_receiver_city"] as? String ?? ""
        if let bid = json["bid"] as? [[String: Any]] {
            
            self.bid = bid.map { Bid(json: $0) }
        }
    }
    init(){
        
    }
}

class Bid {
    var id:Int?
    var captainId:Int?
    var price:Int?
    var captainName:String?
    var captainImage:String?
    var captainRate:Double

    
     init(json: [String: Any]) {
        self.id = json["id"] as? Int ?? 0
        self.captainId = json["captain_id"] as? Int ?? 0
        self.price = json["price"] as? Int ?? 0
        self.captainName = json["captain_name"] as? String ?? ""
        self.captainImage = json["captain_image"] as? String ?? ""
        self.captainRate = json["captain_rate"] as? Double ?? 0.0
    }
  
}
