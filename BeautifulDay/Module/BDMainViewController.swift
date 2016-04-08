//
//  BDMainViewController.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/4/7.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

class BDMainViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    let pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        pageViewController.delegate = self
        pageViewController.dataSource = self;
        let mdc = storyboard?.instantiateViewControllerWithIdentifier("BDMusicDayController")
        pageViewController.setViewControllers([mdc!], direction: .Forward, animated: true, completion: nil)
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
    }
    
    // MARK: - UIPageViewController delegate and data source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let mdc = storyboard?.instantiateViewControllerWithIdentifier("BDMusicDayController") as!BDMusicDayController
            mdc.view.backgroundColor = UIColor.blueColor()
        mdc.locationLabel.text = "before"
        //            viewController.view.backgroundColor = UIColor(red: (CGFloat(arc4random_uniform(100))) / 100 , green:  (CGFloat(arc4random_uniform(100))) / 100, blue:  (CGFloat(arc4random_uniform(100))) / 100, alpha:  (CGFloat(arc4random_uniform(100))) / 100)
        return mdc
    }
    //            button.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:arc4random_uniform(100)/100.0];
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let mdc = storyboard?.instantiateViewControllerWithIdentifier("BDMusicDayController") as!BDMusicDayController
            mdc.view.backgroundColor = UIColor.blueColor()
        mdc.locationLabel.text = "after"
        //            mdc!.view.backgroundColor = UIColor(red: (CGFloat(arc4random_uniform(100))) / 100 , green:  (CGFloat(arc4random_uniform(100))) / 100, blue:  (CGFloat(arc4random_uniform(100))) / 100, alpha:  (CGFloat(arc4random_uniform(100))) / 100)
        
        return mdc
    }
    
    
}
