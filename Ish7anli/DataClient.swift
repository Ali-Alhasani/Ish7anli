//
//  ViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/18/18.
//  Copyright © 2017 Ali Al-Hassany. All rights reserved.
//

import UIKit

class DataClient: NSObject {
    
    var profile : Profile?
    var offer = [Offer]()
    var CustomerOrder = [CustomerOffer]()
    var lastOffer = [OldOrder]()
    var archiveOrder = [ArchiveOrder]()
    var cpatainCustomerOrder = [CaptainCustomerOffer]()
    var cpatainActiveOrder = [CaptainCustomerOffer]()
    var captianArchiveOrder = [ArchiveOrder]()
    var captianOffer = [Offer]()
    var allCity = [City]()
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
            DataClient.shared.profile = profile
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
            let activationCode = responseData["activated_code"] as? String ?? ""
            SessionManager.shared.phoneNumber = phone

            success(activationCode)
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
    
    func getOffer(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void){
        APIClient.sendRequest(path: "rate/new_offer", httpMethod: .get, isLangRequired: true , parameters:[:], success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            print(responseData)
            responseData.forEach({ (data) in
                DataClient.shared.offer.append(Offer(json: data))
            })
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func addOffer(addressSenderId:Int,deliveryType:Int,weight:Int,addressReceiverId:Int,receiverName:String,receiverPhone:String,paymentType:Int, success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void){
        APIClient.sendRequest(path: "customer_offer", httpMethod: .post, isLangRequired: false , parameters:["address_sender_id":addressSenderId, "delevary_type":deliveryType,"weight": weight ,"address_receiver_id":addressReceiverId,"receiver_name":receiverName,"receiver_phone":receiverPhone,"payment_type":paymentType], success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            print(responseData)
//            responseData.forEach({ (data) in
//                DataClient.shared.offer.append(Offer(json: data))
//            })
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func getCustomerOrder(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void){
        DataClient.shared.CustomerOrder.removeAll()

        APIClient.sendRequest(path: "customer_user_offer", httpMethod: .get, isLangRequired: false , parameters:[:], success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            print(responseData)
            responseData.forEach({ (data) in
                    DataClient.shared.CustomerOrder.append(CustomerOffer(json: data))
            })
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
  
    func getOldOrder(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void) {
        DataClient.shared.lastOffer.removeAll()
        APIClient.sendRequest(path: "last_offer", httpMethod: .get, isLangRequired: false , parameters:[:], success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            print(responseData)
            responseData.forEach({ (data) in
                DataClient.shared.lastOffer.append(OldOrder(json: data))
            })
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func getArchiveOrder(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void) {
        DataClient.shared.archiveOrder.removeAll()
        APIClient.sendRequest(path: "archive_order", httpMethod: .get, isLangRequired: false , parameters:[:], success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            print(responseData)
            responseData.forEach({ (data) in
                DataClient.shared.archiveOrder.append(ArchiveOrder(json: data))
            })
            success()
        }) { (error) in
            failuer(error)
        }
    }

    
    
    func getNewOfferCaptain(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void){
        
        DataClient.shared.cpatainCustomerOrder.removeAll()
        APIClient.sendRequest(path: "customer_offer", httpMethod: .get, isLangRequired: false , parameters:[:], success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            print(responseData)
            responseData.forEach({ (data) in
                DataClient.shared.cpatainCustomerOrder.append(CaptainCustomerOffer(json: data))
            })
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func getActiveOrder(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void){
        DataClient.shared.cpatainActiveOrder.removeAll()
        APIClient.sendRequest(path: "active_order", httpMethod: .get, isLangRequired: false , parameters:[:], success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            print(responseData)
            responseData.forEach({ (data) in
                DataClient.shared.cpatainActiveOrder.append(CaptainCustomerOffer(json: data))
            })
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func getCaptianArchiveOrder(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void){
        DataClient.shared.captianArchiveOrder.removeAll()
        APIClient.sendRequest(path: "archive_order", httpMethod: .get, isLangRequired: false , parameters:[:], success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            print(responseData)
            responseData.forEach({ (data) in
    DataClient.shared.captianArchiveOrder.append(ArchiveOrder(json: data))
            })
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    func getCaptianOffer(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void){
        DataClient.shared.captianOffer.removeAll()
        APIClient.sendRequest(path: "rate/captain_offer", httpMethod: .get, isLangRequired: true , parameters:[:], success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            print(responseData)
            responseData.forEach({ (data) in
                DataClient.shared.captianOffer.append(Offer(json: data))
            })
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func loginCaptain(password:String,success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void) {
        SessionManager.loadPhoneNumber()
        APIClient.sendRequest(path: "captain_login", httpMethod: .post, isLangRequired: false , parameters:["phone":  "05925029502","password":password], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            let activationCode = responseData["activated_code"] as? String ?? ""
            SessionManager.shared.token = (responseData["token_type"] as? String ?? "") + " " + (responseData["access_token"] as? String ?? "")
            SessionManager.shared.isUserLogged = false
            SessionManager.shared.isCaptainLogged = true
            //          SessionManager.shared.currentUser = DataClient.shared.user
            SessionManager.saveSessionManager()
            

//            responseData.forEach({ (data) in
//                DataClient.shared.captianOffer.append(CustomerOffer(json: data))
//            })
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    
    func captainRegister(name:String,email:String,password:String,phone:String,cardNumber:String,cardImage:String,licenseImage:String,carForm:String,contractImage:String,financialAccountNumber:String,captainType:String,success: @escaping (_ activationCode:String) ->Void, failuer: @escaping (_ error: Error) -> Void) {
        APIClient.sendRequest(path: "captain_register", httpMethod: .post, isLangRequired: false , parameters:[:], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            let activationCode = responseData["activated_code"] as? String ?? ""
            success(activationCode)
            
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func activateCaptain(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void, activiationCode : String){

    }
    
    
    func captainAddOffer(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void, cityIdFrom : Int,goDate : String,goTime : String,cityIdTo : Int,arrivalDate:String ,arrivalTime:String,price:String ) {
        
        
        APIClient.sendRequest(path: "captain_offer", httpMethod: .post, isLangRequired: false , parameters:["city_id_from": cityIdFrom, "go_date": goDate ,"go_time": goTime, "city_id_to" : cityIdTo, "arrival_date": arrivalDate, "arrival_time" : arrivalTime, "price" : price], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    func captainBidOffer(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void ,customerOfferId :Int , price:String) {
        APIClient.sendRequest(path: "bid_offer", httpMethod: .post, isLangRequired: false , parameters:["customer_offer_id":customerOfferId ,"price": price], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func captainCancelOffer(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void ,customerOfferId :Int ) {
        APIClient.sendRequest(path: "cancel_offer", httpMethod: .post, isLangRequired: false , parameters:["customer_offer_id":customerOfferId], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func getCity(success: @escaping () ->Void, failuer: @escaping (_ error: Error) -> Void) {
         DataClient.shared.allCity.removeAll()
        APIClient.sendRequest(path: "city", httpMethod: .get, isLangRequired: true , parameters:[:], success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            print(responseData)
            responseData.forEach({ (data) in
                DataClient.shared.allCity.append(City(json: data))
            })
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
  
    
    
    
    
  
}
