//
//  BDNetworkService.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/4/27.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

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

func fetchAlbumList(failure: NSError -> Void, success:([Album] -> Void)) {
    let date = NSDate()
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let startDate = formatter.stringFromDate(date)
    let param = ["startdate" : startDate, "count" : 10]
    Alamofire.request(.POST, "http://www.dev4love.com/api/daylist", parameters: param as? [String : AnyObject], encoding: .JSON, headers: nil).responseArray(keyPath: "album_datas") { (response: Response<[Album], NSError>) in
        let albumlist = response.result.value
        print(albumlist)
        
        if let al = albumlist {
            success(al)
        }else {
            let error = Error.errorWithCode(0, failureReason: "album is nil")
            failure(error)
        }
    }
}

func fetchAlbumDetailInfo(albumId:Int, failure: NSError -> Void, success:(AlbumDetail -> Void)) {
    var userId = 0
    if let u = currentUser.userId {
        userId = u
    }
    let param = ["album_id" : albumId, "user_id" : userId]
    Alamofire.request(.POST, "http://www.dev4love.com/api/albumdetail", parameters: param, encoding: .JSON, headers: nil).responseObject{ (response: Response<AlbumDetail, NSError>) in
        let albumDetail = response.result.value
        print(albumDetail)
        
        if let ad = albumDetail {
            success(ad)
        }else {
            let error = Error.errorWithCode(0, failureReason: "album is nil")
            failure(error)
        }
    }
}

func postZan(albumId:Int, zanStatus:Bool, failure: NSError -> Void, success:(Zan -> Void)) {
    guard currentUser.isLogin else {
        return
    }
    
    let zanInt = zanStatus ? 1 : 0
    let param = ["album_id" : albumId, "user_id" : currentUser.userId!, "zan" : zanInt]
    Alamofire.request(.POST, "http://www.dev4love.com/api/zan", parameters: param, encoding: .JSON, headers: nil).responseObject(keyPath: "zaninfo") { (response: Response<Zan, NSError>) in
        let z = response.result.value
        print(z)
        
        if let z = z {
            success(z)
        }else {
            let error = Error.errorWithCode(0, failureReason: "comment fail")
            failure(error)
        }
    }
}

func postComment(albumId:Int, content:String,failure: NSError -> Void, success:(Comment -> Void)) {
    guard currentUser.isLogin else {
        return
    }
    let param = ["album_id" : albumId, "user_id" : currentUser.userId!, "content" : content] as [String : AnyObject]
    Alamofire.request(.POST, "http://www.dev4love.com/api/comment", parameters: param, encoding: .JSON, headers: nil).responseObject(keyPath: "comment"){ (response: Response<Comment, NSError>) in
        let c = response.result.value
        print(c)
        
        if let c = c {
            success(c)
        }else {
            let error = Error.errorWithCode(0, failureReason: "comment fail")
            failure(error)
        }
    }
}

func postRegister(uid:String, username:String, password:String, failure: NSError -> Void, success:((Int, String) -> Void)) {
    let param = ["uid" : uid, "user_name" : username, "password" : password]
    Alamofire.request(.POST, "http://www.dev4love.com/api/register", parameters: param, encoding: .JSON, headers: nil).responseJSON { (response) in
        if let result = response.result.value {
            switch result["status"] as! String {
            case "occupied":
                print("occupied")
                failure(NSError(domain: "http://www.dev4love.com/api/register", code: 1, userInfo: ["reason" : "occupied"]))
            case "success":
                print(result["token"])
                success(result["user_id"] as! Int, result["token"] as! String)
            default:
                break
            }
        }
    }
}

func postLogin(uid:String, password:String, failure: NSError -> Void, success:((Int, String, String) -> Void)) {
    let param = ["uid" : uid, "password" : password]
    Alamofire.request(.POST, "http://www.dev4love.com/api/login", parameters: param, encoding: .JSON, headers: nil).responseJSON { (response) in
        if let result = response.result.value {
            switch result["status"] as! String {
            case "wrong_password":
                print("wrong_password")
                failure(NSError(domain: "http://www.dev4love.com/api/login", code: 1, userInfo: ["reason" : "wrong_password"]))
            case "unregister":
                print("unregister")
                failure(NSError(domain: "http://www.dev4love.com/api/login", code: 2, userInfo: ["reason" : "unregister"]))
            case "success":
                print(result["token"])
                success(result["user_id"] as! Int, result["user_name"] as! String, result["token"] as! String)
            default:
                break
            }
        }
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