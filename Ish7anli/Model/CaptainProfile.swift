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
    init(json: [String: Any]) {
        if let address = json["address"] as? [[String: Any]] {
            self.address = address.map { Address(json: $0) }
        }
    }
}
