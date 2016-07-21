//
//  BDTrack.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/4/8.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import DOUAudioStreamer
class BDTrack: NSObject {
    /**
     *  @property (nonatomic, strong) NSString *artist;
     @property (nonatomic, strong) NSString *title;
     @property (nonatomic, strong) NSURL *audioFileURL;
     */
    var title : String = ""
    var audioFileURL : NSURL? {
        get {
            if audioFileURL == nil {
                return nil
            }else {
                return audioFileURL
            }
        }
    }
    var artist : String = ""
    
//    func audioFileURL() -> NSURL! {
//        if audioFileURL == nil {
//            return nil
//        }else {
//            return audioFileURL
//        }
//    }
    
}
