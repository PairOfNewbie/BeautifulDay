//
//  InputBar.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/5/29.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

class InputBar: UIView {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!

    var clickAction: (() -> Void)?
    override func awakeFromNib() {
        leftLabel.layer.borderColor = UIColor.blackColor().CGColor
        leftLabel.layer.borderWidth = 1 / UIScreen.mainScreen().scale
        rightLabel.layer.borderColor = UIColor.blackColor().CGColor
        rightLabel.layer.borderWidth = 1 / UIScreen.mainScreen().scale
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(InputBar.click))
        self.addGestureRecognizer(tap)
    }
    
    func click() {
        if let action = clickAction {
            action()
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
