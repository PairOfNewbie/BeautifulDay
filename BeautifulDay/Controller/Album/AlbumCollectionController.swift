//
//  AlbumCollectionController.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/5/18.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

private let albumCollectionNormalCellReuseIdentifier = "AlbumCollectionNormalCell"
//private let albumCollectionCardCellReuseIdentifier = "AlbumCollectionCardCell"
private let loadMoreCollectionCellReuseIdentifier = "LoadMoreCollectionCell"

class AlbumCollectionController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.registerNib(UINib(nibName:albumCollectionNormalCellReuseIdentifier, bundle: nil) , forCellWithReuseIdentifier: albumCollectionNormalCellReuseIdentifier)
        //        self.collectionView!.registerNib(UINib(nibName: albumCollectionCardCellReuseIdentifier, bundle: nil) , forCellWithReuseIdentifier: albumCollectionCardCellReuseIdentifier)
        self.collectionView!.registerNib(UINib(nibName: loadMoreCollectionCellReuseIdentifier, bundle: nil) , forCellWithReuseIdentifier: loadMoreCollectionCellReuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: UICollectionView
    private enum Section: Int {
        case Content
        case LoadMore
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case Section.Content.rawValue:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(albumCollectionNormalCellReuseIdentifier, forIndexPath: indexPath) as! AlbumCollectionNormalCell
            return cell
        case Section.LoadMore.rawValue:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(loadMoreCollectionCellReuseIdentifier, forIndexPath: indexPath) as! LoadMoreCollectionCell
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let mpc = self.storyboard?.instantiateViewControllerWithIdentifier("MediaPreviewController") as? MediaPreviewController {
            self.presentViewController(mpc, animated: true, completion: { 
                
            })
        }
    }
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
     return false
     }
     
     override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
     
     }
     */
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
}

extension AlbumCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch indexPath.section {
        case Section.Content.rawValue:
            return CGSizeMake(UIScreen.mainScreen().bounds.width, 80)
        case Section.LoadMore.rawValue:
            return CGSizeMake(UIScreen.mainScreen().bounds.width, 80)
        default:
            return CGSizeZero
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        switch section {
        case Section.Content.rawValue:
            return UIEdgeInsetsZero
        case Section.LoadMore.rawValue:
            return UIEdgeInsetsZero
        default:
            return UIEdgeInsetsZero
        }
    }
}
