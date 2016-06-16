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

func fetchAlbumList(failure: NSError -> Void, success:((Bool, [Album]) -> Void)) {
    let param = ["startdate" : "2016-05-18", "count" : 2]
    Alamofire.request(.POST, "http://www.dev4love.com/api/daylist", parameters: param, encoding: .JSON, headers: nil).responseArray(keyPath: "album_datas") { (response: Response<[Album], NSError>) in
        let albumlist = response.result.value
        print(albumlist)
        
        if let al = albumlist {
            success(true, al)
        }else {
            let error = Error.errorWithCode(0, failureReason: "album is nil")
            failure(error)
        }
    }
}


func fetchAlbumDetailInfo(albumId:String, userId:String, failure: NSError -> Void, success:((Bool, AlbumDetail) -> Void)) {
    let param = ["album_id" : albumId, "user_id" : userId]
    Alamofire.request(.POST, "http://www.dev4love.com/api/albumdetail", parameters: param, encoding: .JSON, headers: nil).responseObject{ (response: Response<AlbumDetail, NSError>) in
        let albumDetail = response.result.value
        print(albumDetail)
        
        if let ad = albumDetail {
            success(true, ad)
        }else {
            let error = Error.errorWithCode(0, failureReason: "album is nil")
            failure(error)
        }
    }
}

enum ZanType: Int {
    case Zan = 0
    case Unzan
}

func postZan(albumId:String, userId:String, zan:ZanType, failure: NSError -> Void, success:((Bool, Zan) -> Void)) {
    let param = ["album_id" : albumId, "user_id" : userId, "zan" : "\(zan.rawValue)"]
    Alamofire.request(.POST, "http://www.dev4love.com/api/zan", parameters: param, encoding: .JSON, headers: nil).responseObject{ (response: Response<Zan, NSError>) in
        let c = response.result.value
        print(c)
        
        if let c = c {
            success(true, c)
        }else {
            let error = Error.errorWithCode(0, failureReason: "comment fail")
            failure(error)
        }
    }
}

func postComment(albumId:String, userId:String, content:String,failure: NSError -> Void, success:((Bool, Comment) -> Void)) {
    let param = ["album_id" : albumId, "user_id" : userId, "content" : content]
    Alamofire.request(.POST, "http://www.dev4love.com/api/comment", parameters: param, encoding: .JSON, headers: nil).responseObject(keyPath: "comment"){ (response: Response<Comment, NSError>) in
        let c = response.result.value
        print(c)
        
        if let c = c {
            success(true, c)
        }else {
            let error = Error.errorWithCode(0, failureReason: "comment fail")
            failure(error)
        }
    }
}

func postRegister(username:String, password:String, failure: NSError -> Void, success:((Bool, String) -> Void)) {
    let param = ["user_name" : username, "password" : password]
    Alamofire.request(.POST, "http://www.dev4love.com/api/register", parameters: param, encoding: .JSON, headers: nil).responseJSON { (response) in
        if let result = response.result.value as? [String : String] {
            switch result["status"]! {
            case "occupied":
                print("occupied")
                failure(NSError(domain: "http://www.dev4love.com/api/register", code: 1, userInfo: ["reason" : "occupied"]))
            case "success":
                print(result["token"])
                success(true, result["token"]!)
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