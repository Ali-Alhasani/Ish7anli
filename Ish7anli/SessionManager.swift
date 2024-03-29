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
    var cpatainType:String = ""
    var displayName:String = ""
    var isPending:Bool = false
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
       guard let displayName = UserDefaults.standard.value(forKey: "displayName") as? String else {return}
        guard let tempPhone = UserDefaults.standard.value(forKey: "phoneNumber") as? String else {return}

        SessionManager.shared.token = tempDic["token"] as! String
        SessionManager.shared.userId = userID
        SessionManager.shared.displayName = displayName
        SessionManager.shared.phoneNumber = tempPhone
        
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
        
        if let boolValue = tempDic["isPending"] as? Bool {
             SessionManager.shared.isPending = boolValue
             if boolValue{
            }
        }
    }
    
     class func loadPhoneNumber(){
        guard let tempPhone = UserDefaults.standard.value(forKey: "phoneNumber") as? String else {return}
          SessionManager.shared.phoneNumber = tempPhone
        print( SessionManager.shared.phoneNumber)
    }
    class func saveCpatainType(){
       let cpatainType =  SessionManager.shared.cpatainType
        UserDefaults.standard.set(cpatainType, forKey: "cpatainType")
        
    }
    
    class func loadCpatainType(){
        guard let tempType = UserDefaults.standard.value(forKey: "cpatainType") as? String else {return}
        SessionManager.shared.cpatainType = tempType
    }
    
    class func saveSessionManager(){
        var tempDic:Dictionary<String,Any> = [:]
        tempDic["token"] = SessionManager.shared.token
        tempDic["isUserLogged"] = SessionManager.shared.isUserLogged
        tempDic["isCaptainLogged"] = SessionManager.shared.isCaptainLogged
        tempDic["isPending"] = SessionManager.shared.isPending
        let userID = SessionManager.shared.userId
        let phoneNumber = SessionManager.shared.phoneNumber
        let displayName = SessionManager.shared.displayName
     //   guard let currentUser = SessionManager.shared.currentUser else {return}
        // UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: currentUser), forKey: "User")
        UserDefaults.standard.set(tempDic, forKey: "SessionManager")
        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
        UserDefaults.standard.set(userID, forKey: "userId")
        UserDefaults.standard.set(displayName, forKey: "displayName")
        
        

        
    }
    
    class func clearSessionManager(){
        UserDefaults.standard.removeObject(forKey: "SessionManager")
        UserDefaults.standard.removeObject(forKey: "phoneNumber")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "displayName")
        UserDefaults.standard.removeObject(forKey: "cpatainType")
       

        SessionManager.shared.token = ""
        SessionManager.shared.isUserLogged = false
        SessionManager.shared.isCaptainLogged = false
        SessionManager.shared.userId = ""
        SessionManager.shared.displayName = ""
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


