//
//  BDMusicPlayView.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/4/11.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

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
    
    //Animation
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
