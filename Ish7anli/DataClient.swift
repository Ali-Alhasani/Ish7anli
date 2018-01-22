//
//  ViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/18/18.
//  Copyright © 2017 Ali Al-Hassany. All rights reserved.
//

import UIKit

class DataClient: NSObject {
    
    //var profile : Profile?
    

    class var shared: DataClient{
        struct Static{
            static let instance = DataClient()
        }
        return Static.instance
    }
    
    func getProfile(success: @escaping (Profile) ->Void, failuer: @escaping (_ error: Error) -> Void){
        //DataClient.shared.profile?.removeAll()
        APIClient.sendRequest(path: "customer_profile", httpMethod: .get, isLangRequired: false , parameters:[:], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            //responseData.forEach({ (data) in
                 //DataClient.shared.profile = Profile(json: responseData)
            
            //})
             let profile = Profile(json: responseData)
            success(profile)
           
            
        }) { (error) in
            failuer(error)
        }
    }
    func deleteAddress(id:String, success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void){
        //DataClient.shared.profile?.removeAll()
        APIClient.sendRequest(path: "customer_address/" + id + "/delete", httpMethod: .delete, isLangRequired: false , parameters:[:], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            //responseData.forEach({ (data) in
            //DataClient.shared.profile = Profile(json: responseData)
            
            //})
            //let profile = Profile(json: responseData)
            success()
            
            
        }) { (error) in
            failuer(error)
        }
    }
    
    func addAddress(title:String,details:String,longitude:Double,latitude:Double, success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void){
        let parameters = ["title":title,"details":details,"longitude":longitude,"latitude":latitude] as [String : Any]
        APIClient.sendRequest(path: "customer_address", httpMethod: .post, isLangRequired: false , parameters:parameters, success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            //responseData.forEach({ (data) in
            //DataClient.shared.profile = Profile(json: responseData)
            
            //})
            //let profile = Profile(json: responseData)
            success()
            
            
        }) { (error) in
            failuer(error)
        }
    }
    
    func logIn(phone:String,success: @escaping (_ activationCode:String) ->Void, failuer: @escaping (_ error: Error) -> Void){
        let parameters = ["phone":phone] as [String : Any]
        APIClient.sendRequest(path: "customer_login", httpMethod: .post, isLangRequired: false , parameters:parameters, success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            let activationCode = responseData["activated_code"] as? Int ?? 0
            success(String(activationCode))
        }) { (error) in
            failuer(error)
            print(error)
        }
    }
    
     func activate(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void, activiationCode : String){
        APIClient.sendRequest(path: "customer_activate", httpMethod: .post, isLangRequired: false , parameters:["activated_code": activiationCode], success: { (response) in
            let responseData = response as! [String : Any]
            print(responseData)
            SessionManager.shared.token = (responseData["token_type"] as? String ?? "") + " " + (responseData["access_token"] as? String ?? "")
            SessionManager.shared.isUserLogged = true
  //          SessionManager.shared.currentUser = DataClient.shared.user
            SessionManager.saveSessionManager()
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
  
}
