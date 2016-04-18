//
//  BDMusicDayController.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/4/5.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit
import DOUAudioStreamer
import Alamofire
//import AFNetworking
import SDWebImage
let bottomHeight : CGFloat = 44 + 2

class BDMusicDayController: UIViewController, UIScrollViewDelegate {
    var pageIndex : Int = 0
    var trk :Track? = nil
    
    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mpView: BDMusicPlayView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Life Cycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        Alamofire.request(.POST, "http://112.74.106.192/Beautiful_Day/App/index.php", parameters: ["date" : "2016-04-14"], encoding: .JSON, headers: nil).responseJSON { [unowned self](response:Response<AnyObject, NSError>)  in
            if response.result.isSuccess {
                if let dic = response.result.value {
                    self.trk = Track()
                    if let artist = dic.objectForKey("text") as? String {
                        self.trk?.artist = artist
                        self.mpView.artistLabel.text = artist
                    }
                    if let title = dic.objectForKey("text") as? String {
                        self.trk?.title = title
                    }
                    if let audioFileURLString = dic.objectForKey("music") as? String {
                        self.trk?.audioFileURL = NSURL(string: audioFileURLString)
                        self.resetStreamer()
                    }
                    if let imageURLString = dic.objectForKey("img") as? String {
                        self.bgView.sd_setImageWithURL(NSURL(string: imageURLString))
                    }
                    if let date = dic.objectForKey("date") as? String {
                        self.dateLabel.text = date
                    }
                    if let location = dic.objectForKey("text") as? String {
                        self.locationLabel.text = location
                    }
                    if let des = dic.objectForKey("text") as? String {
                        self.descriptionLabel.text = des
                    }
                }
            }
        }
        
        /// 替换方法，使用AFNetworking
        //        let res = AFJSONResponseSerializer()
        //        res.acceptableContentTypes = ["text/html"]
        //        let manager = AFHTTPSessionManager()
        //        manager.responseSerializer = res
        //        manager.requestSerializer = AFJSONRequestSerializer()
        //        manager.POST("http://112.74.106.192/Beautiful_Day/App/index.php", parameters: ["date" : "2016-04-14"], success: { (task:NSURLSessionDataTask, response:AnyObject?) in
        //            print(task)
        //            print(response)
        //        }) { (task:NSURLSessionDataTask?, error:NSError) in
        //            print(error)
        //        }
        
        //        trk = Track()
        //        trk?.artist = "jason"
        //        trk?.title = "jason's song"
        //        trk?.audioFileURL = NSURL(string: "http://mr7.doubanio.com/2867d1b829cddffa78318cdb7a3b34ce/1/fm/song/p616953_128k.mp4")
        //        resetStreamer()
    }
    //MARK: - Initial Setup
    func setupSubviews() {
//        let panGesture = UIPanGestureRecognizer(target: self, action: NSSelectorFromString("onPan:"))
//        mpView.addGestureRecognizer(panGesture)
//        let tapGesture = UITapGestureRecognizer(target: self, action: NSSelectorFromString("onTap:"))
//        mpView.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - DOUPlayer
    var streamer : DOUAudioStreamer? = nil
    func canncelStreamer() {
        if streamer != nil {
            streamer?.pause()
            streamer!.removeObserver(self, forKeyPath: "status")
            streamer!.removeObserver(self, forKeyPath: "duration")
            streamer!.removeObserver(self, forKeyPath: "currentTime")
            streamer!.removeObserver(self, forKeyPath: "bufferingRatio")
            streamer = nil
        }
    }
    
    func resetStreamer() {
        canncelStreamer()
        assert(trk?.audioFileURL != nil, "the audio url is nil")
        streamer = DOUAudioStreamer(audioFile: trk)
        mpView.streamer = streamer
        streamer?.addObserver(self, forKeyPath: "status", options: .New, context: nil)
        streamer?.addObserver(self, forKeyPath: "duration", options: .New, context: nil)
        streamer?.addObserver(self, forKeyPath: "currentTime", options: .New, context: nil)
        streamer?.addObserver(self, forKeyPath: "bufferingRatio", options: .New, context: nil)
        streamer?.play()
    }
    
    //MARK: - KVO
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "duration" {
            print("duration")
        }
        if keyPath == "currentTime" {
            print("currentTime")
        }
        if let kp = keyPath {
            switch kp {
            case "status":
                dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
                    self.mpView.updateStatus()
                })
            case "duration":
                fallthrough
            case "currentTime":
                dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
                    self.mpView.updateProgress()
                    })
            case "bufferingRatio":
                dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
                    self.mpView.updateBufferingStatus()
                    })
            default:
                super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            }
        }
    }
    
    //MARK: - Gesture
    var origin : CGPoint = CGPointZero
    var final : CGPoint = CGPointZero
    
    func onPan(panGesture: UIPanGestureRecognizer) {
        print("onPan")
        let translation = panGesture.translationInView(self.view)
        let velocity = panGesture.velocityInView(self.view)
        
        switch panGesture.state {
        case .Began:
            print("began")
            origin = mpView.frame.origin
            break
        case .Changed:
            print("changed")
            if origin.y + translation.y >= 0 {
                mpView.transform = CGAffineTransformMakeTranslation(0, translation.y)
            }
            break
        case .Ended:
            print("ended")
            fallthrough
        case .Cancelled:
            print("cancelled")
            print(velocity)
            var finalOrigin = CGPointZero
            if velocity.y >= 0 {
                finalOrigin.y = CGRectGetHeight(self.view.frame) - bottomHeight
            }
            var f = self.view.bounds
            f.origin = finalOrigin
            UIView.animateWithDuration(0.3, animations: {
                self.mpView.transform = CGAffineTransformIdentity
                self.mpView.frame = f
                }, completion: { (finished: Bool) in
            })
            break
        default:
            break
        }
    }
    
    func onTap(tapGesture: UITapGestureRecognizer) {
        print("onTap:")
    }
    
}
