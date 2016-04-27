//
//  BDService.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/4/27.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import Foundation
import Alamofire

#if STAGING
let baseURL = NSURL(string: "https://park-staging.catchchatchina.com/api")!
#else
let baseURL = NSURL(string: "https://api.soyep.com")!
#endif

// Model
struct LoginUser: CustomStringConvertible {
    let userID: String
    let username: String
    let avatarURLString: String?
    
    var description: String {
        return "LoginUser(userID: \(userID), userkname: \(username), avatarURLString: \(avatarURLString))"
    }
}

func register(username:String, userid:String, failure: Error -> Void, success:Bool -> Void) {
    let parameters = ["username": username, "userid": userid]
    Alamofire.request(.POST, "", parameters: parameters, encoding: .JSON, headers: nil).responseJSON { (response: Response<AnyObject, NSError>) in
        print("response")
    }
    
}

func fetchOneDayInfo(date:String) {
    let parameters = ["date": "2016-04-14"]
    Alamofire.request(.POST, "", parameters: parameters, encoding: .JSON, headers: nil).responseJSON { (response: Response<AnyObject, NSError>) in
        print("response")
    }
}


//func registerMobile(mobile: String, withAreaCode areaCode: String, nickname: String, failureHandler: FailureHandler?, completion: Bool -> Void) {
//    let requestParameters: JSONDictionary = [
//        "mobile": mobile,
//        "phone_code": areaCode,
//        "nickname": nickname,
//        "longitude": 0, // TODO: 注册时不好提示用户访问位置，或许设置技能或用户利用位置查找好友时再提示并更新位置信息
//        "latitude": 0
//    ]
//    
//    let parse: JSONDictionary -> Bool? = { data in
//        if let state = data["state"] as? String {
//            if state == "blocked" {
//                return true
//            }
//        }
//        
//        return false
//    }
//    
//    let resource = jsonResource(path: "/v1/registration/create", method: .POST, requestParameters: requestParameters, parse: parse)
//    
//    apiRequest({_ in}, baseURL: yepBaseURL, resource: resource, failure: failureHandler, completion: completion)
//}