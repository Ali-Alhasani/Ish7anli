//
//  Offer.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/23/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation

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
        self.id = json["id"] as? Int ?? 0
        self.captainId = json["captain_id"] as? Int ?? 0
        self.cityIdFrom = json["city_id_from"] as? Int ?? 0
        self.goDate = json["go_date"] as? String ?? "يلعنك "
        self.goTime = json["go_time"] as? String ?? ""
        self.cityIdTo = json["city_id_to"] as? Int ?? 0
        self.arrivalDate = json["arrival_date"] as? String ?? "يا كلب"
        self.arrivalTime = json["arrival_time"] as? String ?? "كس اختك"
        self.price = json["price"] as? String ?? "كس امك"
        self.captainImage = json["captain_image"] as? String ?? ""
        self.captainName = json["captain_name"] as? String ?? "يلعن منظرك"
        self.captainRate = json["captain_rate"] as? Double ?? 0.0
        self.cityNameFrom = json["city_name_from"] as? String ?? "يا ابن الحرام"
        self.cityNameTo = json["city_name_to"] as? String ?? "ولك استحي ع حالك"
    }
    init(){
        
    }
}
