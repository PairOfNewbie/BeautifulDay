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
    let imageArray = ["slide1", "slide2", "slide3", "slide4", "slide5"]
    var currentIndex : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        pageViewController.delegate = self
        pageViewController.dataSource = self;
        let mdc = viewControllerAtIndex(0)
        pageViewController.setViewControllers([mdc!], direction: .Forward, animated: true, completion: nil)
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
    }
    
    // MARK: - UIPageViewController delegate and data source
    //    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    //        let mdc = storyboard?.instantiateViewControllerWithIdentifier("BDMusicDayController") as!BDMusicDayController
    //            mdc.view.backgroundColor = UIColor.blueColor()
    //        mdc.locationLabel.text = "before"
    //        //            viewController.view.backgroundColor = UIColor(red: (CGFloat(arc4random_uniform(100))) / 100 , green:  (CGFloat(arc4random_uniform(100))) / 100, blue:  (CGFloat(arc4random_uniform(100))) / 100, alpha:  (CGFloat(arc4random_uniform(100))) / 100)
    //        return mdc
    //    }
    //    //            button.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:arc4random_uniform(100)/100.0];
    //
    //    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    //        let mdc = storyboard?.instantiateViewControllerWithIdentifier("BDMusicDayController") as!BDMusicDayController
    //            mdc.view.backgroundColor = UIColor.blueColor()
    //        mdc.locationLabel.text = "after"
    //        //            mdc!.view.backgroundColor = UIColor(red: (CGFloat(arc4random_uniform(100))) / 100 , green:  (CGFloat(arc4random_uniform(100))) / 100, blue:  (CGFloat(arc4random_uniform(100))) / 100, alpha:  (CGFloat(arc4random_uniform(100))) / 100)
    //
    //        return mdc
    //    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! BDMusicDayController).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! BDMusicDayController).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if (index == self.imageArray.count) {
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> BDMusicDayController? {
        if self.imageArray.count == 0 || index >= self.imageArray.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("BDMusicDayController") as!BDMusicDayController
        pageContentViewController.view.backgroundColor = UIColor.whiteColor()
        pageContentViewController.bgView.image = UIImage(named: imageArray[index])
        pageContentViewController.dateLabel.text = "index is \(index)"
        pageContentViewController.pageIndex = index
        currentIndex = index
        
        return pageContentViewController
    }
}
