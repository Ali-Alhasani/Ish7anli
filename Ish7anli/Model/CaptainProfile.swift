//
//  CaptainProfile.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/13/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation
class CaptainProfile {
    var address = [Address]()
    var financial_account_number:String?
    init(json: [String: Any]) {
        self.financial_account_number = json["financial_account_number"] as? String ?? ""
        if let address = json["address"] as? [[String: Any]] {
            self.address = address.map { Address(json: $0) }
        }
    }
}
