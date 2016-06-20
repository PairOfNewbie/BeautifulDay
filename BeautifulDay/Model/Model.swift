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

struct Comment: Mappable {
    var albumId: String?
    var content: String?
    var userId: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        albumId <- map["album_id"]
        content <- map["content"]
        userId <- map["user_id"]
    }
}

struct Zan: Mappable {
    var zanId : String?
    var zanStatus: Bool?
    var albumId: String?
    var userName: String?
    var userId: String?
    init?(_ map: Map) {
        
    }
    mutating func mapping(map: Map) {
        zanId <- map["zan_id"]
        zanStatus <- map["zan_status"]
        albumId <- map["album_id"]
        userId <- map["user_id"]
    }
}

struct Album: Mappable {
    var albumId: String?
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
    var userid: String?
    var username: String?
    var tel: String?
    var token: String?
    var isLogin: Bool {
        get {
            if userid != nil {
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
        userid = defaults.objectForKey("userid") as? String
        username = defaults.objectForKey("username") as? String
        tel = defaults.objectForKey("tel") as? String
        token = defaults.objectForKey("token") as? String
    }
    
    func save() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(userid, forKey: "userid")
        defaults.setObject(username, forKey: "username")
        defaults.setObject(tel, forKey: "tel")
        defaults.setObject(token, forKey: "token")
        defaults.synchronize()
    }
}

var currentUser = User()