//
//  MediaPreviewController.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/5/19.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

enum PreviewMedia {
    case WebImage(imageURL: NSURL, linkURL: NSURL)
}

let mediaViewCellID = "MediaViewCell"

class MediaPreviewController: UIViewController {
    var previewMedias: [PreviewMedia] = []
    var startIndex: Int = 0
    var currentIndex: Int = 0
    
    @IBOutlet weak var mediasCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mediasCollectionView.registerNib(UINib(nibName: mediaViewCellID, bundle: nil), forCellWithReuseIdentifier: mediaViewCellID)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MediaPreviewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    private func configureCell(cell: MediaViewCell, withPreviewMedia previewMedia: PreviewMedia) {
        
        cell.activityIndicator.startAnimating()
        
        switch previewMedia {
            
        case .WebImage(_, _):
            
            let imageView = UIImageView()
            
            imageView.sd_setImageWithURL(NSURL(string: "http://img4.goumin.com/attachments/photo/0/0/51/13112/3356750o2.jpg"), placeholderImage: nil, options: .RetryFailed, completed: { (image, error, cacheType, imageURL) in
                dispatch_async(dispatch_get_main_queue()) {
                    cell.mediaView.image = image
                    
                    cell.activityIndicator.stopAnimating()
                }
            })
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(mediaViewCellID, forIndexPath: indexPath) as! MediaViewCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = cell as? MediaViewCell {
            let previewMedia = previewMedias[indexPath.item]
            configureCell(cell, withPreviewMedia: previewMedia)
        }
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return UIScreen.mainScreen().bounds.size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        //return UIEdgeInsetsZero
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let newCurrentIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        
        if newCurrentIndex != currentIndex {
            
            let indexPath = NSIndexPath(forItem: newCurrentIndex, inSection: 0)
            
            guard let cell = mediasCollectionView.cellForItemAtIndexPath(indexPath) as? MediaViewCell else {
                return
            }
            
            let previewMedia = previewMedias[newCurrentIndex]
            
            prepareForShareWithCell(cell, previewMedia: previewMedia)
            
            currentIndex = newCurrentIndex
            
            print("scroll to new media")
        
        }
    }
    
    private func prepareForShareWithCell(cell: MediaViewCell, previewMedia: PreviewMedia) {
    }
}
