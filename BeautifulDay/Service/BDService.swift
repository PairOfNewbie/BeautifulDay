//
//  BDService.swift
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

//MARK:- test
func fetchTestInfo(failure: NSError -> Void, success: ((Bool, Track) -> Void)) {
    Alamofire.request(.POST, "http://112.74.106.192/Beautiful_Day/App/index.php", parameters: ["date" : "2016-04-14"], encoding: .JSON, headers: nil).responseJSON { (response:Response<AnyObject, NSError>)  in
        if response.result.isSuccess {
            if let dic = response.result.value {
                let trk = Track()
                if let artist = dic.objectForKey("text") as? String {
                    trk.artist = artist
                }
                if let title = dic.objectForKey("text") as? String {
                    trk.title = title
                }
                if let audioFileURLString = dic.objectForKey("music") as? String {
                    trk.audioFileURL = NSURL(string: audioFileURLString)
                }
                if let imageURLString = dic.objectForKey("img") as? String {
                    //                    self.bgView.sd_setImageWithURL(NSURL(string: imageURLString))
                }
                if let date = dic.objectForKey("date") as? String {
                    //                    self.dateLabel.text = date
                }
                if let location = dic.objectForKey("text") as? String {
                    //                    self.locationLabel.text = location
                }
                if let des = dic.objectForKey("text") as? String {
                    //                    self.descriptionLabel.text = des
                }
                success(true, trk)
            }
        }
    }
}

func fetchAblumList(failure: NSError -> Void, success:((Bool, [Album]) -> Void)) {
    Alamofire.request(.POST, "http://112.74.106.192/Beautiful_Day/App/index.php", parameters: ["date" : "2016-04-14"], encoding: .JSON, headers: nil).responseArray { (reponse: Response<[Album], NSError>) in
        let albumlist = reponse.result.value
        print(albumlist)
        
        if let al = albumlist {
            success(true, al)
        }else {
            let error = Error.errorWithCode(0, failureReason: "album is nil")
            failure(error)
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