//
//  BDAudioService.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/5/4.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

/// Implementation: every module which is about to play music should set trk and updateAction of the audio service and resetStreamer. then it will play the music.

import UIKit
import DOUAudioStreamer

class BDAudioService: NSObject {
    static let shareManager = BDAudioService()
    
    var streamer : DOUAudioStreamer? = nil 
    
    var trk: Track? = nil

    enum UpdateType {
        case Status
        case Duration
        case BufferingRatio
    }
    var updateAction: ((type: UpdateType) -> Void)?
    
    //MARK: - Public
    func pause() {
        streamer?.pause()
    }
    func play() {
        streamer?.play()
    }
    //MARK:  DOUPlayer
    func canncelStreamer() {
        if streamer != nil {
            streamer?.stop()
//            mpView.rotateIcon.stopAnimating()
            streamer!.removeObserver(self, forKeyPath: "status")
            streamer!.removeObserver(self, forKeyPath: "duration")
            streamer!.removeObserver(self, forKeyPath: "bufferingRatio")
            streamer = nil
        }
    }
    
    func resetStreamer(trk: Track, updateAction:((type: UpdateType) -> Void)?) {
        canncelStreamer()
        assert(trk.audioFileURL != nil, "the audio url is nil")
        self.trk = trk
        self.updateAction = updateAction
        streamer = DOUAudioStreamer(audioFile: trk)
//        mpView.streamer = streamer
        streamer?.addObserver(self, forKeyPath: "status", options: .New, context: nil)
        streamer?.addObserver(self, forKeyPath: "duration", options: .New, context: nil)
        streamer?.addObserver(self, forKeyPath: "bufferingRatio", options: .New, context: nil)
        streamer?.play()
    }
    
    //MARK: - KVO
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if let kp = keyPath {
            switch kp {
            case "status":
                print("status is \(streamer?.status)")
                dispatch_async(dispatch_get_main_queue(), {
                    self.updateAction?(type: .Status)
                })
                if streamer?.status == .Some(.Finished) {
                    self .resetStreamer(trk!, updateAction: self.updateAction)
                }
            case "duration":
                dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
                    self.updateAction?(type: .Duration)
                    })
            case "bufferingRatio":
                dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
                    self.updateAction?(type: .BufferingRatio)
                    })
            default:
                super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            }
        }
    }

}
