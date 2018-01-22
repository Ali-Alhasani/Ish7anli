//
//  LLError.swift
//  limitless
//
//  Copyright © 2017 A2A. All rights reserved.
//

import UIKit

class LLError: NSObject, Error {

    var status:Bool
    var message:String
    
    init(status: Bool?, message: String) {
        self.status = status ?? true
        self.message = message
    }
}
