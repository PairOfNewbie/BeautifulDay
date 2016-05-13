//
//  MusicPlayBar.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/4/11.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit
import DOUAudioStreamer
class MusicPlayBar: UIView {
    var trk: Track? {
        didSet {
            if trk?.audioFileURL == BDAudioService.shareManager.trk?.audioFileURL {
                BDAudioService.shareManager.updateAction = { [unowned self](type) in
                    switch type {
                    case .Status:
                        self.updateStatus()
                    case .Duration:
                        self.updateProgress()
                    case .BufferingRatio:
                        self.updateBufferingStatus()
                    }
                }
                if BDAudioService.shareManager.streamer?.status == .Some(.Playing) {
                    rotate()
                    self.updateProgress()
                }
            }
        }
    }
    var timer: NSTimer?
    //    var animateProgress : Double = 0 {
    //        didSet {
    //            rotateIcon.layer.timeOffset = animateProgress
    //        }
    //    }
    var streamer: DOUAudioStreamer? {
        get {
            return BDAudioService.shareManager.streamer
        }
    }
    
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
    
    deinit {
        timer?.invalidate()
    }
    private func commonInit() {
        let tapGesture = UITapGestureRecognizer(target: self, action: NSSelectorFromString("onTap:"))
        addGestureRecognizer(tapGesture)
    }
    
    //    func setupSubviews() {
    //        let fromPoint = rotateIcon.center
    //        let toPoint = self.center
    //        let movePath = UIBezierPath()
    //        movePath.moveToPoint(fromPoint)
    //        movePath.addLineToPoint(toPoint)
    //        let animation = CAKeyframeAnimation(keyPath: "position")
    //        animation.path = movePath.CGPath
    //        //        animation.duration = 1
    //        //        animation.removedOnCompletion = false
    //        //        animation.fillMode = kCAFillModeForwards
    //        //        animation.autoreverses = false
    //
    //        let animation1 = CABasicAnimation(keyPath: "transform.scale")
    //        animation1.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
    //        animation1.toValue = NSValue(CATransform3D: CATransform3DMakeScale(3, 3, 1))
    //        //        animation1.removedOnCompletion = false
    //        //        animation1.duration = 1
    //        //        animation1.fillMode = kCAFillModeForwards
    //        //        animation1.autoreverses = false
    //
    //        let animationGroup = CAAnimationGroup()
    //        animationGroup.animations = [animation, animation1]
    //        animationGroup.removedOnCompletion = false
    //        animationGroup.duration = 1
    //        animationGroup.fillMode = kCAFillModeForwards
    //        animationGroup.autoreverses = false
    //
    //        rotateIcon.layer.addAnimation(animationGroup, forKey: "rotateIcon")
    //    }
    
    //MAKR:- Action
    func onTap(tapGesture: UITapGestureRecognizer) {
        print("onTap:")
        if streamer?.status == .Playing {
            if trk?.audioFileURL == BDAudioService.shareManager.trk?.audioFileURL {
                BDAudioService.shareManager.pause()
            }else {
                if let trk = self.trk {
                    BDAudioService.shareManager.resetStreamer(trk, updateAction: { [unowned self](type) in
                        switch type {
                        case .Status:
                            self.updateStatus()
                        case .Duration:
                            self.updateProgress()
                        case .BufferingRatio:
                            self.updateBufferingStatus()
                        }
                        })
                }
            }
        }else if streamer?.status == .Paused {
            BDAudioService.shareManager.play()
        }else {
            if let trk = self.trk {
                BDAudioService.shareManager.resetStreamer(trk, updateAction: { [unowned self](type) in
                    switch type {
                    case .Status:
                        self.updateStatus()
                    case .Duration:
                        self.updateProgress()
                    case .BufferingRatio:
                        self.updateBufferingStatus()
                    }
                    })
            }
        }
    }
    //MARK:- Public
    func updateBufferingStatus() {
        remainingLabel.text = String(format: "Received %.2f/%.2f MB (%.2f %%), Speed %.2f MB/s", Float(streamer!.receivedLength) / 1024 / 1024, Float(streamer!.expectedLength) / 1024 / 1024, streamer!.bufferingRatio * 100.0, Float(streamer!.downloadSpeed) / 1024 / 1024)
    }
    func updateStatus() {
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
        let status = streamer!.status
        if status == .Playing {
            if rotateIcon.isAnimating() {
                resumeLayer(rotateIcon.layer)
            }else {
                rotate()
            }
        }else if status == .Paused {
            pauseLayer(rotateIcon.layer)
        }else if status == .Idle {
            rotateIcon.stopAnimating()
        }else if status == .Finished {
            rotateIcon.stopAnimating()
        }else if status == .Buffering {
            
        }else if status == .Error {
            rotateIcon.stopAnimating()
        }
    }
    
    func updateProgress() {
        if  streamer!.duration == 0{
            progressView.setProgress(0, animated: false)
        }else {
            progressView.setProgress(Float(streamer!.currentTime / streamer!.duration), animated: true)
        }
    }
    
    //MARK: Animation
    func rotate() {
        rotateIcon.animationImages = rotateImages
        rotateIcon.startAnimating()
    }
    
    func pauseLayer(layer: CALayer) {
        let pauseTime = layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        layer.speed = 0
        layer.timeOffset = pauseTime
    }
    
    func resumeLayer(layer: CALayer) {
        if layer.speed == 1 {
            return
        }
        let pausedTime = layer.timeOffset
        layer.speed = 1
        layer.timeOffset = 0
        layer.beginTime = 0
        let timeSicePause = layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        layer.beginTime = timeSicePause
    }
}
