//
//  Model.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/5/7.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

// todo: how to use : https://github.com/tristanhimmelman/AlamofireObjectMapper

import Foundation
import ObjectMapper
/*
 "comment_id": 33,
 "album_id": 2,
 "content": "这个世界还好吗",
 "user_id": 3,
 "user_name": "David",
 "created_at": "2016-06-23 22:25:32",
 "updated_at": "2016-06-23 22:25:32"
 */
struct Comment: Mappable {
    var commentId: Int?
    var albumId: Int?
    var content: String?
    var userId: Int?
    var userName: String?
    var createdAt: String?
    var updatedAt: String?
    
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        commentId <- map["comment_id"]
        albumId <- map["album_id"]
        content <- map["content"]
        userId <- map["user_id"]
        userName <- map["user_name"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
    }
}

struct Zan: Mappable {
    var zanId : Int?
    var albumId: Int?
    var zanStatus: Bool? {
        get {
            if zanStatusInt == 1 {
                return true
            }else {
                return false
            }
        }
        set {
            if newValue == true {
                zanStatusInt = 1
            }else {
                zanStatusInt = 0
            }
        }
    }
    var zanStatusInt: Int?
    var userName: String?
    var userId: Int?
    init?(_ map: Map) {
        
    }
    mutating func mapping(map: Map) {
        zanId <- map["zan_id"]
        zanStatusInt <- map["zan"]
        albumId <- map["album_id"]
        userName <- map["user_name"]
        userId <- map["user_id"]
    }
}

struct Album: Mappable {
    var albumId: Int?
    var date: String?
    var text: String?
    var imgUrl: String?
    var musicUrl: String?
    var pageUrl: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        albumId <- map["album_id"]
        date <- map["date"]
        text <- map["text"]
        imgUrl <- map["img_url"]
        musicUrl <- map["music_url"]
        pageUrl <- map["page_url"]
    }
}

struct AlbumDetail: Mappable {
    var zan: Bool?
    var albuminfo: Album?
    var commentList: [Comment]?
    var zanList: [Zan]?

    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        zan <- map["zan"]
        albuminfo <- map["albuminfo"]
        commentList <- map["commentlist"]
        zanList <- map["zanlist"]
    }
}

var albumList = [Album]()

struct User {
    var userId: Int?
    var username: String?
    var tel: String?
    var token: String?
    var isLogin: Bool {
        get {
            if userId != nil {
                return true
            }else {
                let sb = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                let lc = sb.instantiateViewControllerWithIdentifier("LoginMainController")
                let nc = BDNavigationController(rootViewController: lc)
                UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(nc, animated: true, completion: { 
                    
                })
                return false
            }
        }
    }

    init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        userId = defaults.objectForKey("userid") as? Int
        username = defaults.objectForKey("username") as? String
        tel = defaults.objectForKey("tel") as? String
        token = defaults.objectForKey("token") as? String
    }
    
    func save() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(userId, forKey: "userid")
        defaults.setObject(username, forKey: "username")
        defaults.setObject(tel, forKey: "tel")
        defaults.setObject(token, forKey: "token")
        defaults.synchronize()
    }
}

var currentUser = User()