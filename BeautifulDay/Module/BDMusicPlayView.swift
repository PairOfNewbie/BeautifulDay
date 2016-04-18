//
//  BDMusicPlayView.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/4/11.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit
import DOUAudioStreamer
class BDMusicPlayView: UIView {
    lazy var rotateImages : [UIImage] = {
        var arr = [UIImage]()
        for index in 0...126 {
            arr.append(UIImage(named: "cd_\(index)")!)
        }
        return arr
    }()
    
    @IBOutlet weak var rotateIcon: UIImageView!
    @IBOutlet weak var remainingLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    //MARK:- Initial
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
    }
    
    //MARK:- Public
    func updateBufferingStatus(streamer: DOUAudioStreamer) {
        //todo
        /**
         [_miscLabel setText:[NSString stringWithFormat:@"Received %.2f/%.2f MB (%.2f %%), Speed %.2f MB/s", (double)[_streamer receivedLength] / 1024 / 1024, (double)[_streamer expectedLength] / 1024 / 1024, [_streamer bufferingRatio] * 100.0, (double)[_streamer downloadSpeed] / 1024 / 1024]];
         
         if ([_streamer bufferingRatio] >= 1.0) {
         NSLog(@"sha256: %@", [_streamer sha256]);
         }
         */
        remainingLabel.text = String(format: "Received %.2f/%.2f MB (%.2f %%), Speed %.2f MB/s", Float(streamer.receivedLength) / 1024 / 1024, Float(streamer.expectedLength) / 1024 / 1024, streamer.bufferingRatio * 100.0, Float(streamer.downloadSpeed) / 1024 / 1024)
    }
    func updateStatus(status: DOUAudioStreamerStatus) {
        //todo
        /**
         *
         switch ([_streamer status]) {
         case DOUAudioStreamerPlaying:
         [_statusLabel setText:@"playing"];
         [_buttonPlayPause setTitle:@"Pause" forState:UIControlStateNormal];
         break;
         
         case DOUAudioStreamerPaused:
         [_statusLabel setText:@"paused"];
         [_buttonPlayPause setTitle:@"Play" forState:UIControlStateNormal];
         break;
         
         case DOUAudioStreamerIdle:
         [_statusLabel setText:@"idle"];
         [_buttonPlayPause setTitle:@"Play" forState:UIControlStateNormal];
         break;
         
         case DOUAudioStreamerFinished:
         [_statusLabel setText:@"finished"];
         [self _actionNext:nil];
         break;
         
         case DOUAudioStreamerBuffering:
         [_statusLabel setText:@"buffering"];
         break;
         
         case DOUAudioStreamerError:
         [_statusLabel setText:@"error"];
         break;
         }
         */
        
        if status == .Playing {
            if rotateIcon.isAnimating() {
                return
            }else {
                rotate()
            }
        }else if status == .Paused {
            rotateIcon.stopAnimating()
        }else if status == .Idle {
            rotateIcon.stopAnimating()
        }else if status == .Finished {
            rotateIcon.stopAnimating()
        }else if status == .Buffering {
            rotateIcon.stopAnimating()
        }else if status == .Error {
            rotateIcon.stopAnimating()
        }
    }
    
    func updateProgress(streamer: DOUAudioStreamer) {
        //todo
        /**
         if ([_streamer duration] == 0.0) {
         [_progressSlider setValue:0.0f animated:NO];
         }
         else {
         [_progressSlider setValue:[_streamer currentTime] / [_streamer duration] animated:YES];
         }
         */
        if  streamer.duration == 0{
            progressView.setProgress(0, animated: false)
        }else {
            progressView.setProgress(Float(streamer.currentTime / streamer.duration), animated: true)
        }
    }
    
    //MARK: Animation
    func rotate() {
        rotateIcon.animationImages = rotateImages
        rotateIcon.startAnimating()
    }
    //MARK: - KVO
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "contentOffset" {
            
        }
    }
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
