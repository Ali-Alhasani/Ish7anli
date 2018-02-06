//
//  Notifications.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/4/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation

class Notifications {
    var id:Int?
    var customerTitle:String?
    var adminTitle:String?
    
     init(json: [String: Any]) {
        self.id = json["id"] as? Int ?? 0
        self.customerTitle = json["customer_title"] as? String ?? ""
        self.adminTitle = json["admin_title"] as? String ?? ""
    }
    
    
    
}
