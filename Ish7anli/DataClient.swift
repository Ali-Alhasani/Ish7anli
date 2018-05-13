//
//  ViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/18/18.
//  Copyright © 2017 Ali Al-Hassany. All rights reserved.
//

import UIKit
import SwiftyJSON
class DataClient: NSObject {
    
    var profile : Profile?
    var cpatainProfile: CaptainProfile?
    var offer = [Offer]()
    var offerPrice = [Offer]()
    var offerFiltered = [Offer]()
    var CustomerOrder = [CustomerOffer]()
    var lastOffer = [OldOrder]()
    var archiveOrder = [ArchiveOrder]()
    var cpatainCustomerOrder = [CaptainCustomerOffer]()
    
    var cpatainCustomerOrderFiltered = [CaptainCustomerOffer]()
    var cpatainActiveOrder = [CaptainCustomerOffer]()
    var captianArchiveOrder = [ArchiveOrder]()
    var captianOffer = [Offer]()
    var captianPriceOffer = [Offer]()
    var allCity = [City]()
    var notifications = [Notifications]()
    var myOffer = [Offer]()
    class var shared: DataClient{
        struct Static{
            static let instance = DataClient()
        }
        return Static.instance
    }
    
    func getProfile(success: @escaping (Profile) ->Void, failuer: @escaping (_ error: LLError) -> Void){
        //DataClient.shared.profile?.removeAll()
        APIClient.sendRequest(path: "customer_profile", httpMethod: .get, isLangRequired: false , parameters:[:], success: { (response) in
            if let responseData = response as? [String : Any] {
                print(responseData)
                //responseData.forEach({ (data) in
                //DataClient.shared.profile = Profile(json: responseData)
                
                //})
                let profile = Profile(json: responseData)
                DataClient.shared.profile = profile
                success(profile)
            }
            
        }) { (error) in
            failuer(error)
        }
    }
    func deleteAddress(id:Int, success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        //DataClient.shared.profile?.removeAll()
        APIClient.sendRequest(path: "customer_address/" + String(id) + "/delete", httpMethod: .delete, isLangRequired: false , parameters:[:], success: { (response) in
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
    
    func deleteCaptainAddress(id:Int, success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        //DataClient.shared.profile?.removeAll()
        APIClient.sendRequest(path: "captain_address/" + String(id) + "/delete", httpMethod: .delete, isLangRequired: false , parameters:[:], success: { (response) in
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
    
    func addAddress(title:String,details:String,longitude:Double,latitude:Double,cityId:Int, success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        let parameters = ["title":title,"details":details,"longitude":longitude,"latitude":latitude,"city_id":cityId] as [String : Any]
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
    
    func logIn(phone:String,success: @escaping (_ activationCode:String ,_ isExist:Bool, _ isCaptain:Bool) ->Void, failuer: @escaping (_ error: LLError) -> Void){
     guard let deviceToken =  UserDefaults.standard.object(forKey: "FCMtoken") as? String else { return }
       //,,"ios_token":deviceToken
        let parameters = ["phone":phone,"ios_token":deviceToken] as [String : Any]
          var isExist = false
          var isCaptain = false
        APIClient.sendRequest(path: "customer_login", httpMethod: .post, isLangRequired: false , parameters:parameters, success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            let isexist =  responseData["user_status"] as? Int ?? 0
            let roleId =  responseData["role_id"] as? Int ?? 0
            if isexist == 3 {
                isExist = true
            }
            if roleId == 2 {
                isCaptain = true
            }
            let activationCode = responseData["activated_code"] as? String ?? ""
            SessionManager.shared.phoneNumber = phone
            SessionManager.shared.userId = String(responseData["id"] as? Int ?? 0)
            print(SessionManager.shared.userId)
            success(activationCode, isExist, isCaptain)
        }) { (error) in
            failuer(error)
            print(error)
        }
    }
    
    func activate(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void, activiationCode : String){
      

        APIClient.sendRequest(path: "customer_activate", httpMethod: .post, isLangRequired: false , parameters:["activated_code": activiationCode], success: { (response) in
            let responseData = response as! [String : Any]
            
            print(responseData)
            SessionManager.shared.token = (responseData["token_type"] as? String ?? "") + " " + (responseData["access_token"] as? String ?? "")
            SessionManager.shared.isPending = true
            //SessionManager.shared.isUserLogged = true
            //          SessionManager.shared.currentUser = DataClient.shared.user
            SessionManager.saveSessionManager()
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    func getOffer(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        DataClient.shared.offer.removeAll()
        APIClient.sendRequest(path: "rate/new_offer", httpMethod: .get, isLangRequired: true , parameters:[:], success: { (response) in
            if let responseData = response as? [[String : Any]] {
                print(responseData)
                responseData.forEach({ (data) in
                    DataClient.shared.offer.append(Offer(json: data))
                })
                
            }
            success()
        }) { (error) in
            failuer(error)
        }
    }
    func getPriceOffer(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        DataClient.shared.offerPrice.removeAll()
        APIClient.sendRequest(path: "price/new_offer", httpMethod: .get, isLangRequired: true , parameters:[:], success: { (response) in
            if let responseData = response as? [[String : Any]] {
                print(responseData)
                responseData.forEach({ (data) in
                    DataClient.shared.offerPrice.append(Offer(json: data))
                })
            }
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func addOffer(addressSenderId:Int,deliveryType:Int,weight:Int,addressReceiverId:Int,receiverName:String,receiverPhone:String,paymentType:Int, success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
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
    func addOffer2(addressSenderId:Int,deliveryType:Int,weight:Int,addressReceiverId:Int,receiverName:String,receiverPhone:String,paymentType:Int,captainOfferId:Int, success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        APIClient.sendRequest(path: "customer_offer", httpMethod: .post, isLangRequired: false , parameters:["address_sender_id":addressSenderId, "delevary_type":deliveryType,"weight": weight ,"address_receiver_id":addressReceiverId,"receiver_name":receiverName,"receiver_phone":receiverPhone,"payment_type":paymentType,"captain_offer_id":captainOfferId], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            //            responseData.forEach({ (data) in
            //                DataClient.shared.offer.append(Offer(json: data))
            //            })
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func getCustomerOrder(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        DataClient.shared.CustomerOrder.removeAll()
        
        APIClient.sendRequest(path: "customer_user_offer", httpMethod: .get, isLangRequired: true , parameters:[:], success: { (response) in
            if  let responseData = response as? [[String : Any]] {
                print(responseData)
                responseData.forEach({ (data) in
                    DataClient.shared.CustomerOrder.append(CustomerOffer(json: data))
                })
            }
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func getOldOrder(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void) {
        DataClient.shared.lastOffer.removeAll()
        APIClient.sendRequest(path: "last_offer", httpMethod: .get, isLangRequired: true , parameters:[:], success: { (response) in
            if let responseData = response as? [[String : Any]] {
                print(responseData)
                responseData.forEach({ (data) in
                    DataClient.shared.lastOffer.append(OldOrder(json: data))
                })
            }
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func getArchiveOrder(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void) {
        DataClient.shared.archiveOrder.removeAll()
        APIClient.sendRequest(path: "archive_order", httpMethod: .get, isLangRequired: false , parameters:[:], success: { (response) in
            if let responseData = response as? [[String : Any]] {
                print(responseData)
                responseData.forEach({ (data) in
                    DataClient.shared.archiveOrder.append(ArchiveOrder(json: data))
                })
            }
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    
    func getNewOfferCaptain(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        
        DataClient.shared.cpatainCustomerOrder.removeAll()
        APIClient.sendRequest(path: "customer_offer", httpMethod: .get, isLangRequired: true , parameters:[:], success: { (response) in
            if let responseData = response as? [[String : Any]] {
            print(responseData)
            responseData.forEach({ (data) in
                DataClient.shared.cpatainCustomerOrder.append(CaptainCustomerOffer(json: data))
            })
            }
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func getActiveOrder(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        DataClient.shared.cpatainActiveOrder.removeAll()
        APIClient.sendRequest(path: "active_order", httpMethod: .get, isLangRequired: true , parameters:[:], success: { (response) in
            if let responseData = response as? [[String : Any]] {
            print(responseData)
            responseData.forEach({ (data) in
                DataClient.shared.cpatainActiveOrder.append(CaptainCustomerOffer(json: data))
            })
            }
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func getCaptianArchiveOrder(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        DataClient.shared.captianArchiveOrder.removeAll()
        APIClient.sendRequest(path: "archive_order", httpMethod: .get, isLangRequired: true , parameters:[:], success: { (response) in
            if let responseData = response as? [[String : Any]] {
            print(responseData)
            responseData.forEach({ (data) in
                DataClient.shared.captianArchiveOrder.append(ArchiveOrder(json: data))
            })
            }
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    func getCaptianOffer(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        DataClient.shared.captianOffer.removeAll()
        APIClient.sendRequest(path: "rate/captain_offer", httpMethod: .get, isLangRequired: true , parameters:[:], success: { (response) in
            if let responseData = response as? [[String : Any]] {
            print(responseData)
            responseData.forEach({ (data) in
                DataClient.shared.captianOffer.append(Offer(json: data))
            })
            }
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    func getCaptianPrieOffer(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
     DataClient.shared.captianPriceOffer.removeAll()
        APIClient.sendRequest(path: "price/captain_offer", httpMethod: .get, isLangRequired: true , parameters:[:], success: { (response) in
            if let responseData = response as? [[String : Any]] {
                print(responseData)
                responseData.forEach({ (data) in
                    DataClient.shared.captianPriceOffer.append(Offer(json: data))
                })
            }
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func loginCaptain(password:String,success: @escaping () ->Void, failuer: @escaping (_ error: LLError , _ userStatus:String,_ activated_code:String) -> Void) {
        SessionManager.loadPhoneNumber()
      
        APIClient.sendRequest2(path: "captain_login", httpMethod: .post, isLangRequired: false , parameters:["phone":  SessionManager.shared.phoneNumber,"password":password], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
       
            
            SessionManager.shared.token = (responseData["token_type"] as? String ?? "") + " " + (responseData["access_token"] as? String ?? "")
            SessionManager.shared.cpatainType = responseData["captain_type"] as? String ?? ""
          
            SessionManager.shared.isUserLogged = false
            SessionManager.shared.isCaptainLogged = true
            SessionManager.shared.userId = String(responseData["id"] as? Int ?? 0)
            
            //          SessionManager.shared.currentUser = DataClient.shared.user
            SessionManager.saveCpatainType()
            SessionManager.saveSessionManager()

            
            //            responseData.forEach({ (data) in
            //                DataClient.shared.captianOffer.append(CustomerOffer(json: data))
            //            })
            success()
        }) { (error,userStatus,activated_code) in
            failuer(error,userStatus,activated_code)
        }
    }
    

    func captainRegister(name:String,email:String,password:String,phone:String,cardNumber:String,cardImage:String,licenseImage:String,carForm:String,contractImage:String,financialAccountNumber:String,captainType:Int,title:String,details:String,longitude:Double,latitude:Double,captainImage:String,cityId:Int,success: @escaping (_ activationCode:String) ->Void, failuer: @escaping (_ error: LLError) -> Void) {
        SessionManager.loadPhoneNumber()
        let dict = ["name":name, "email":email,"password":password,"phone":SessionManager.shared.phoneNumber,"card_number":cardNumber, "contract_image":contractImage,"financial_account_number":financialAccountNumber,"captain_type":captainType,"license_image":licenseImage,"card_image":cardImage,"car_form":carForm,"title":title,"details":details,"longitude":longitude,"latitude":latitude,"image":captainImage,"city_id":cityId] as [String : Any]
  
        APIClient.sendRequest(path: "captain_register", httpMethod: .post, isLangRequired: false , parameters: dict, success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            let activationCode = responseData["activated_code"] as? String ?? ""
            success(activationCode)
            
        }) { (error) in
            failuer(error)
        }
    }
    
    func captainRegister3(financialAccountNumber:String,captainType:Int,success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void) {
        SessionManager.loadPhoneNumber()
        let dict = ["financial_account_number":financialAccountNumber,"captain_type":captainType] as [String : Any]
        APIClient.sendRequest(path: "captain_profile/update", httpMethod: .patch, isLangRequired: false , parameters: dict, success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            //            let activationCode = responseData["activated_code"] as? String ?? ""
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    func captainNewRegister(name:String,email:String,password:String,phone:String,cardNumber:String,success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void) {
        SessionManager.loadPhoneNumber()
        let dict = ["name":name, "email":email,"password":password,"phone":SessionManager.shared.phoneNumber,"card_number":cardNumber] as [String : Any]
        APIClient.sendRequest(path: "captain_register", httpMethod: .post, isLangRequired: false , parameters: dict, success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
           // let activationCode = responseData["activated_code"] as? String ?? ""
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func activateCaptain(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void, activiationCode : String){
        APIClient.sendRequest(path: "captain_activate", httpMethod: .post, isLangRequired: false , parameters:["activated_code": activiationCode], success: { (response) in
            let responseData = response as! [String : Any]
            print(responseData)
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func captainAddOffer(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void, cityIdFrom : Int,goDate : String,goTime : String,cityIdTo : Int,arrivalDate:String ,arrivalTime:String,price:String,address_receiver_id:Int, address_sender_id:Int) {
        
        
        APIClient.sendRequest(path: "captain_offer", httpMethod: .post, isLangRequired: false , parameters:["city_id_from": cityIdFrom, "go_date": goDate ,"go_time": goTime, "city_id_to" : cityIdTo, "arrival_date": arrivalDate, "arrival_time" : arrivalTime, "price" : price,"address_sender_id":address_sender_id,"address_receiver_id":address_receiver_id], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    func captainBidOffer(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void ,customerOfferId :Int , price:String) {
        APIClient.sendRequest(path: "bid_offer", httpMethod: .post, isLangRequired: false , parameters:["customer_offer_id":customerOfferId ,"price": price], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func captainCancelOffer(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void ,customerOfferId :Int ) {
        APIClient.sendRequest(path: "cancel_offer", httpMethod: .post, isLangRequired: false , parameters:["customer_offer_id":customerOfferId], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func getCity(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void) {
        DataClient.shared.allCity.removeAll()
        APIClient.sendRequest(path: "city", httpMethod: .get, isLangRequired: true , parameters:[:], success: { (response) in
            if let responseData = response as? [[String : Any]] {
            print(responseData)
            responseData.forEach({ (data) in
                DataClient.shared.allCity.append(City(json: data))
            })
            }
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func rateCatpain(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void,customerOfferId :Int ,captainId :Int ,rate:Double) {
        
        APIClient.sendRequest(path: "captain_rate", httpMethod: .post, isLangRequired: false , parameters:["captain_id":captainId , "rate":rate, "customer_offer_id" :customerOfferId], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            print(responseData)
            
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    func chooseCaptain(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void,customerOfferId :Int ,captainId :Int ){
        
        APIClient.sendRequest(path: "choose_captain", httpMethod: .post, isLangRequired: false , parameters:["captian_id":captainId ,  "customer_offer_id" :customerOfferId], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
             print(responseData)
            
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func uploadProfilePhoto(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void,photo :String ){
        
        APIClient.sendRequest(path: "customer_profile/update", httpMethod: .patch, isLangRequired: false , parameters:["image":photo], success: { (response) in
            //let responseData = response as? [String : Any] ?? [:]
            //print(response)
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    func uploadCaptainPhotos(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void,parameters:Dictionary<String, Any>){
        
        APIClient.sendRequest(path: "captain_profile/update", httpMethod: .patch, isLangRequired: false , parameters:parameters, success: { (response) in
            //let responseData = response as? [String : Any] ?? [:]
            //print(response)
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    func updateCaptainProfile(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void,parameters:Dictionary<String, Any> ){
        
        APIClient.sendRequest(path: "captain_profile/update", httpMethod: .patch, isLangRequired: false , parameters:parameters , success: { (response) in
            //let responseData = response as? [String : Any] ?? [:]
            //print(response)
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    func saveProfileCustomer(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void,email :String,name :String ,image:String){
        
        APIClient.sendRequest(path: "customer_profile/update", httpMethod: .patch, isLangRequired: false , parameters:["email":email,"name":name,"image":image], success: { (response) in
            //let responseData = response as? [String : Any] ?? [:]
            //print(response)
            SessionManager.shared.displayName = name
            SessionManager.saveSessionManager()
            success()
            
        }) { (error) in
            failuer(error)
        }
    }
    
    func updateProfileCustomer(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void,email :String,name :String){
        
        APIClient.sendRequest(path: "customer_profile/update", httpMethod: .patch, isLangRequired: false , parameters:["email":email,"name":name], success: { (response) in
            //let responseData = response as? [String : Any] ?? [:]
            //print(response)
            SessionManager.shared.displayName = name
            SessionManager.saveSessionManager()
            success()
            
        }) { (error) in
            failuer(error)
        }
    }

    func getCaptainProfile(success: @escaping (CaptainProfile) ->Void, failuer: @escaping (_ error: LLError) -> Void){
       // DataClient.shared.cpatainProfile.removeAll()
        APIClient.sendRequest(path: "captain_profile", httpMethod: .get, isLangRequired: false , parameters:[:], success: { (response) in
            if let responseData = response as? [String : Any] {
            print(responseData)
//            responseData.forEach({ (data) in
//            //DataClient.shared.profile = Profile(json: responseData)
//                DataClient.shared.cpatainProfile.append(Address(json: data))
//            })
            let profile = CaptainProfile(json: responseData)
            DataClient.shared.cpatainProfile = profile
                 success(profile)
            //}
           
            }
            
        }) { (error) in
            failuer(error)
        }
    }
    
    func CaptainAddAddress(title:String,details:String,longitude:Double,latitude:Double,cityId: Int, success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        let parameters = ["title":title,"details":details,"longitude":longitude,"latitude":latitude,"city_id":cityId] as [String : Any]
        APIClient.sendRequest(path: "captain_address", httpMethod: .post, isLangRequired: false , parameters:parameters, success: { (response) in
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
    
    func contactUs( success: @escaping (_ about_us:String, _ email:String, _ phone:String) ->Void, failuer: @escaping (_ error: LLError) -> Void) {
        
        APIClient.sendRequest(path: "info", httpMethod: .get, isLangRequired: true , parameters: [:], success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            print(responseData)
            responseData.forEach({ (data) in
                let aboutUs = data["about_us"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let phone = data["phone"] as? String ?? ""
                success(aboutUs,email,phone)
            })
            //let profile = Profile(json: responseData)
            
            
            
            
        }) { (error) in
            failuer(error)
        }
    }
    
    func notifications(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        DataClient.shared.notifications.removeAll()
        APIClient.sendRequest(path: "notifications", httpMethod: .get, isLangRequired: false , parameters: [:], success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            print(responseData)
            responseData.forEach({ (data) in
                DataClient.shared.notifications.append(Notifications(json: data))
            })
            //let profile = Profile(json: responseData)
            
            
              success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func receivedOffer(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void ,customerOfferId:Int){
        APIClient.sendRequest(path: "received_offer", httpMethod: .post, isLangRequired: false , parameters: ["customer_offer_id":customerOfferId], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
 print(responseData)
            //let profile = Profile(json: responseData)
            
            
            
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    func deliveryOffer(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void ,customerOfferId:Int){
        APIClient.sendRequest(path: "delivery_offer", httpMethod: .post, isLangRequired: false , parameters: ["customer_offer_id":customerOfferId], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
             print(responseData)
            //let profile = Profile(json: responseData)

            
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    func contactUs(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void, name:String,email:String,title:String,content:String){
        APIClient.sendRequest(path: "connect_us", httpMethod: .post, isLangRequired: false , parameters: ["name":name,"email":email,"title":title,"content":content], success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
             print(responseData)
            //let profile = Profile(json: responseData)
            
            
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    func requestAddNotification(data: Dictionary<String, Any>,success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        APIClient.sendRequest(path: "post_notification", httpMethod: .post, isLangRequired: false , parameters: data ,success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
             print(responseData)
            //let profile = Profile(json: responseData)
            
            
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func myOfferCaptain(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        DataClient.shared.myOffer.removeAll()
        APIClient.sendRequest(path: "my_offer_captain", httpMethod: .get, isLangRequired: true , parameters: [:] ,success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            
            //let profile = Profile(json: responseData)
            responseData.forEach({ (data) in
                DataClient.shared.myOffer.append(Offer(json: data))
            })
        
            
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    func cancelMyOfferCaptain(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void,offerId:Int){
        APIClient.sendRequest(path: "cancel_my_offer", httpMethod: .post, isLangRequired: false , parameters: ["offer_id":offerId] ,success: { (response) in
           // let responseData = response as? [String : Any] ?? [:]
            
            //let profile = Profile(json: responseData)

            success()
        }) { (error) in
            failuer(error)
        }
    }
    func forgetPassword(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void){
        SessionManager.loadPhoneNumber()
        APIClient.sendRequest(path: "forget_password", httpMethod: .post, isLangRequired: false , parameters: ["phone":SessionManager.shared.phoneNumber] ,success: { (response) in
           // let responseData = response as? [String : Any] ?? [:]
            
            //let profile = Profile(json: responseData)
            
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    func restPassword(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void,oldPassword:String, newPassword:String){
        
        APIClient.sendRequest(path: "reset_password", httpMethod: .post, isLangRequired: false , parameters: ["old_password":oldPassword, "new_password":newPassword] ,success: { (response) in
           // let responseData = response as? [String : Any] ?? [:]
            
            //let profile = Profile(json: responseData)
            
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func filter(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void, data:[String:Any]){
         DataClient.shared.offerFiltered.removeAll()
        APIClient.sendRequest(path: "filter_offer", httpMethod: .post, isLangRequired: true , parameters: data ,success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            responseData.forEach({ (data) in
                DataClient.shared.offerFiltered.append(Offer(json: data))
            })
        
            //let profile = Profile(json: responseData)
            
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    func orderFilter(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void, data:[String:Any]) {
        DataClient.shared.cpatainCustomerOrderFiltered.removeAll()
        
        APIClient.sendRequest(path: "filter_order", httpMethod: .post, isLangRequired: true , parameters: data ,success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
            responseData.forEach({ (data) in DataClient.shared.cpatainCustomerOrderFiltered.append(CaptainCustomerOffer(json: data))
                
            })
            
            //let profile = Profile(json: responseData)
            
            success()
        }) { (error) in
            failuer(error)
        }
        
    }
    
    
    
    
    func identityCustomer(success: @escaping () ->Void, failuer: @escaping (_ error: LLError) -> Void,  identity:String , orderId:Int){
        APIClient.sendRequest(path: "identity_customer", httpMethod: .post, isLangRequired: false , parameters: ["identity":identity, "order_id":orderId] ,success: { (response) in
            let responseData = response as? [[String : Any]] ?? [[:]]
           
            
            //let profile = Profile(json: responseData)
            
            success()
        }) { (error) in
            failuer(error)
        }
    }
    
    
    func getTerms(success: @escaping (_ terms:String) ->Void, failuer: @escaping (_ error: LLError) -> Void){
        APIClient.sendRequest(path: "terms_and_conditions", httpMethod: .get, isLangRequired: true , parameters: [:] ,success: { (response) in
            let responseData = response as? [String : Any] ?? [:]
            let terms_andـconditions = responseData["terms_andـconditions"] as? String ?? ""
            
            //let profile = Profile(json: responseData)
            
            success(terms_andـconditions)
        }) { (error) in
            failuer(error)
        }
    }
}
