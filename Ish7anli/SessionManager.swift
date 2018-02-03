//
//  ViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/18/18.
//  Copyright © 2017 Ali Al-Hassany. All rights reserved.
//

import UIKit

class SessionManager: NSObject {
    
    var baseUrl: String = "http://shipformeksa.com/api/"
    var token: String = ""
    var phoneNumber:String = ""
    var isUserLogged: Bool = false
    var isCaptainLogged:Bool = false
    var userId:String = ""
    //var currentUser: User!
    
    
    class var shared: SessionManager{
        struct Static{
            static let instance = SessionManager()
        }
        return Static.instance
    }
    
    class func loadSessionManager(){
        guard let tempDic = UserDefaults.standard.value(forKey: "SessionManager") as? Dictionary<String, Any> else {return}
          guard let userID = UserDefaults.standard.value(forKey: "userId") as? String else {return}
        SessionManager.shared.token = tempDic["token"] as! String
        SessionManager.shared.userId = userID
        if let boolValue = tempDic["isUserLogged"] as? Bool {
            SessionManager.shared.isUserLogged = boolValue
            if boolValue{
                print( SessionManager.shared.token)
               // let decodedNSData = UserDefaults.standard.object(forKey: "User") as! Data
              //  let currentUser = NSKeyedUnarchiver.unarchiveObject(with: decodedNSData) as! User
              //  SessionManager.shared.currentUser = currentUser
                
            }
        }
        
        if let boolValue = tempDic["isCaptainLogged"] as? Bool {
            SessionManager.shared.isCaptainLogged = boolValue
            if boolValue{
                print( SessionManager.shared.token)
                // let decodedNSData = UserDefaults.standard.object(forKey: "User") as! Data
                //  let currentUser = NSKeyedUnarchiver.unarchiveObject(with: decodedNSData) as! User
                //  SessionManager.shared.currentUser = currentUser
                
            }
        }
    }
    
     class func loadPhoneNumber(){
        guard let tempPhone = UserDefaults.standard.value(forKey: "phoneNumber") as? String else {return}
          SessionManager.shared.phoneNumber = tempPhone
    }
    
    class func saveSessionManager(){
        var tempDic:Dictionary<String,Any> = [:]
        tempDic["token"] = SessionManager.shared.token
        tempDic["isUserLogged"] = SessionManager.shared.isUserLogged
        tempDic["isCaptainLogged"] = SessionManager.shared.isCaptainLogged
        let userID = SessionManager.shared.userId
        let phoneNumber = SessionManager.shared.phoneNumber
     //   guard let currentUser = SessionManager.shared.currentUser else {return}
        // UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: currentUser), forKey: "User")
        UserDefaults.standard.set(tempDic, forKey: "SessionManager")
        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
        UserDefaults.standard.set(userID, forKey: "userId")
        
        

        
    }
    
    class func clearSessionManager(){
        UserDefaults.standard.removeObject(forKey: "SessionManager")
        SessionManager.shared.token = ""
        SessionManager.shared.isUserLogged = false
    }
    
    

    class func getUrlWithLang() -> String {
        if currentLanguage() == Language.arabic {
            return SessionManager.shared.baseUrl + "ar/"
        }else {
            return SessionManager.shared.baseUrl + "en/"
        }
    }
    
    class func currentLanguage() -> Language{
        let langStr = Locale.current.languageCode
        
        if  (langStr?.contains("ar"))!{
            
            return Language.arabic
        }else{
            
            return Language.english
        }
    }
    
}


enum Language{
    case arabic,english
}


