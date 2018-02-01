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
    }
   
}
