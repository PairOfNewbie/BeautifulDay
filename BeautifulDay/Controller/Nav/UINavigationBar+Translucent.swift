//
//  UINavigationBar+Translucent.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/5/3.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func opaqueBar() {
        self.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Compact)
        self.setBackgroundImage(UIImage(named: "blue2x2"), forBarMetrics: UIBarMetrics.Default)
        self.clipsToBounds = false
    }
    
    func translucentBar() {
        self.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.setBackgroundImage(UIImage(named: "blue2x2"), forBarMetrics: UIBarMetrics.Compact)
        self.clipsToBounds = true
    }
}