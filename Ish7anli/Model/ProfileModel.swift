//
//  Model.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/18/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation

//
//class AddressModel {
//    var address = [Address]()
//}

class Profile {
    var id:Int?
    var name:String?
    var email:String?
    var phone:String?
    var image:String?
    var userStatus:Int?
    var address = [Address]()
    
    init(json: [String: Any]) {
        self.id = json["id"] as? Int ?? 0
        self.name = json["name"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
        self.phone = json["phone"] as? String ?? ""
        self.image = json["image"] as? String ?? ""
        self.userStatus = json["user_status"] as? Int
        
        if let address = json["customer_address"] as? [[String: Any]] {
            
            self.address = address.map { Address(json: $0) }
        }
    }
    init(){
        
    }
}



class Address {
    var title :String?
    var details:String?
    var longitude:String?
    var latitude:String?
    var id:Int?
    
    init(json: [String: Any]) {
        self.title = json["title"] as? String
        self.details = json["details"] as? String
        self.details = json["longitude"] as? String
        self.details = json["latitude"] as? String
        self.id = json["id"] as? Int
    }
}

extension Address: CustomStringConvertible {
    var description: String {
        return "\(title!) : \(details!)"
    }
}
