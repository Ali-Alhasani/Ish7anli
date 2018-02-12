//
//  Offer.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/23/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation
import SwiftyJSON
class Offer {
    
    var id:Int?
    var captainId:Int?
    var cityIdFrom:Int?
    var goDate:String?
    var goTime:String?
    var cityIdTo:Int?
    var arrivalDate:String?
    var arrivalTime:String?
    var price:String?
    var captainImage:String?
    var captainName:String?
    var captainRate:Double?
    var cityNameFrom:String?
    var cityNameTo:String?
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
    var receiverAddressId:Int?
    var senderAddressId:Int?
    var captainAccountNumber:String?
    
    init(json: [String: Any]) {
        let json = JSON(json)
        self.id = json["id"].intValue
        self.captainId = json["captain_id"].intValue
        self.cityIdFrom = json["city_id_from"] .intValue
        self.goDate = json["go_date"].stringValue
        self.goTime = json["go_time"].stringValue
        self.cityIdTo = json["city_id_to"].intValue
        self.arrivalDate = json["arrival_date"].stringValue
        self.arrivalTime = json["arrival_time"].stringValue
        self.price = json["price"].stringValue
        self.captainImage = json["captain_image"].stringValue
        self.captainName = json["captain_name"].stringValue
        self.captainRate = json["captain_rate"].doubleValue
        self.cityNameFrom = json["city_name_from"].stringValue
        self.cityNameTo = json["city_name_to"].stringValue
        
        self.addressSenderTitle = json["sender_address_title"].stringValue
        self.addressSenderDetails = json["sender_address_details"].stringValue
        self.addressSenderLongitude = json["sender_address_longitude"].doubleValue
        self.addressSenderLatitude = json["sender_address_latitude"].doubleValue
        self.addressReceiverTitle = json["receiver_address_title"].stringValue
        self.addressReceiverDetails = json["receiver_address_details"].stringValue
        self.addressReceiverLongitude = json["receiver_address_longitude"].doubleValue
        self.addressReceiverLatitude = json["receiver_address_latitude"].doubleValue
        self.receiverAddressId = json["receiver_address_id"] .intValue
        self.senderAddressId = json["sender_address_id"] .intValue
        self.captainAccountNumber = json["captain_account_number"].stringValue
    }
   
}
