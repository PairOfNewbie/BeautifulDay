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

//public protocol Mappable {
//    init?
//}

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