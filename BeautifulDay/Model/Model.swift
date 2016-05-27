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
    var userName: String?
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        userName <- map["user_name"]
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