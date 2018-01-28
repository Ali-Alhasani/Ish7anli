//
//  ViewController.swift
//  Ish7anli
//
//  Created by Ali Al-Hassany on 1/18/18.
//  Copyright © 2017 Ali Al-Hassany. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class APIClient:NSObject {
    
   
    class func sendRequest(path: String, httpMethod: HTTPMethod ,isLangRequired : Bool ,parameters: Dictionary<String, Any>, success: @escaping (_ response: Any?) -> Void, failure: @escaping (_ error: Error) -> Void){
        var requestURL : String
        if isLangRequired{
             requestURL = SessionManager.getUrlWithLang() + path
        }else{
             requestURL = SessionManager.shared.baseUrl + path
        }
        
        let headers: HTTPHeaders = [
            "Authorization": SessionManager.shared.token,
            "Content-Type" : "application/json",
        ]
        
//        print("base url: \(requestURL)")
//        print("parameters: \(parameters)")
//        print("http method: \(httpMethod)")
//        print("http headers: \(headers)")
        
        var encoding:Any
        
        if httpMethod == .get{
            encoding = URLEncoding.default
        }else{
            encoding = JSONEncoding.default
        }
        
//        debugPrint("request fired : \(Date())")
        Alamofire.request(requestURL, method: httpMethod,parameters:parameters,encoding: encoding as! ParameterEncoding, headers:headers).responseJSON { response in
            
            print("request fired")
            debugPrint("request: \(response.request!)")
            debugPrint("Response Recieved : \(Date())")
            debugPrint("response: \(String(describing: response.result.value))")
            
            switch response.result{
            case .success:
                if let result = response.result.value  {
                    let json = result as! Dictionary<String, Any>
                    let status = json["status"] as? Bool ?? true
                    let message = json["message"] as? String ?? "message"
                    if (status){
                        if let data = json["data"] {
                        success(data)
                        }else{
                          success(json)
                        }
                    }else{
                        let error = LLError.init(status: status, message: message)
                        failure(error)
                    }
                }
            case .failure( let error):
                print("Error \(error.localizedDescription)\n")
                if let result = response.result.value {
                    let json = result as! [String: Any]
                    let message = json["message"] as! String
                    let status = json["status"] as! Bool
                    let error = LLError.init(status: status, message: message)
                    failure(error)
                }
            }
        }
    }
    

     class func sendImageRequest(path: String, success: @escaping (_ image: UIImage) -> Void, failure: @escaping (_ error: Error) -> Void){
        DataRequest.addAcceptableImageContentTypes(["image/jpg"])
       // DataRequest.addAcceptableImageContentTypes(["image/jpg","image/png","binary/octet-stream"])
     // Alamofire.DataRequest.addAcceptableImageContentTypes(["image/jpg", "image/png", "image/jpeg"])
        Alamofire.request(path).responseImage { response in
            debugPrint(response)
           // DataRequest.addAcceptableImageContentTypes(["image/jpg"])

            if let image = response.result.value {
                success(image)
            }
        }
    }
}



