//
//  ErrorHelper.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 2/4/18.
//  Copyright © 2018 Ali Al-Hassany. All rights reserved.
//

import Foundation

class ErrorHelper: NSObject {

    var ok:String = ""
    var alartTitle: String = ""
    var loadingtitle: String = ""
    var message: String = ""
    
    class var shared: ErrorHelper{
        struct Static{
            static let instance = ErrorHelper()
        }
        return Static.instance
    }
    
    
   class func loadErrorHelper(){
    
    if MOLHLanguage.isRTL() {
        ErrorHelper.shared.loadingtitle = "جارى الإرسال"
         ErrorHelper.shared.message = "الرجاء الانتظار"
         ErrorHelper.shared.ok = "موافق"
         ErrorHelper.shared.alartTitle = "تنبيه"
    }else{
        ErrorHelper.shared.loadingtitle = "Sending"
        ErrorHelper.shared.message = "Please Wait"
       ErrorHelper.shared.ok = "Ok"
        ErrorHelper.shared.alartTitle = "Alert"
    }
    }
    
    
}
