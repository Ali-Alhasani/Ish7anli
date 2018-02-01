//
//  City.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/28/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation
class City {
    init(json: [String: Any]) {
        self.id = json["id"] as? Int ?? 0
        self.name = json["city_name"] as? String ?? ""
    }
    var id:Int
    var name:String
   
}
