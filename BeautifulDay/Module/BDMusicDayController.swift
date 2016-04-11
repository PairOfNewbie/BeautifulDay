//
//  BDMusicDayController.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/4/5.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit
import DOUAudioStreamer
class BDMusicDayController: UIViewController, UIScrollViewDelegate {
    var pageIndex : Int = 0
    
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
    //MARK: - Initial Setup
    func setupSubviews() {
        let panGesture = UIPanGestureRecognizer(target: self, action: NSSelectorFromString("onPan:"))
        mpView.addGestureRecognizer(panGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: NSSelectorFromString("onTap:"))
        mpView.addGestureRecognizer(tapGesture)
    }

    //MARK: - DOUPlayer
//    var streamer : DOUAudioStreamer
//    var audioVisualizer : DOUAUdioVisualizer
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
                finalOrigin.y = CGRectGetHeight(self.view.frame) - 44
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
