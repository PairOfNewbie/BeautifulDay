//
//  AlbumDetailController.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/5/4.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

private let albumZanCellIdentifier = "AlbumZanCell"
private let albumCommentCellIdentifier = "AlbumCommentCell"

class AlbumDetailController: UITableViewController {
    @IBOutlet weak var webHeader: UIWebView!
    var albumId = "" {
        didSet {
            fetchAlbumDetailInfo(albumId, userId: "3", failure: { (error) in
                print(error.description)
                }, success: { [unowned self](success, albumDetail) in
                    self.albumDetail = albumDetail
                    
                    // webHeader
                    let request = NSURLRequest(URL: NSURL(string: (albumDetail.albuminfo?.pageUrl)!)!, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 10)
                    self.webHeader.loadRequest(request)
                    self.webHeader.scrollView.scrollEnabled = false
                    
                    self.tableView.reloadData()
            })
        }
    }
    var albumDetail: AlbumDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.automaticallyAdjustsScrollViewInsets = true
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib(nibName: albumZanCellIdentifier, bundle: nil), forCellReuseIdentifier: albumZanCellIdentifier)
        tableView.registerNib(UINib(nibName: albumCommentCellIdentifier, bundle: nil), forCellReuseIdentifier: albumCommentCellIdentifier)
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.hidesBarsOnSwipe = true
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Action
    @objc func zan(sender: UIButton) {
        sender.selected = !sender.selected
        postZan(sender.selected)
    }
    
    private func postZan(status: Bool) {
        // todo 
        
    }
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if let list = albumDetail?.commentList {
                return list.count
            }else {
                return 0
            }
        default:
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let inputBar = NSBundle.mainBundle().loadNibNamed("InputBar", owner: self, options: nil).last as? InputBar
        inputBar?.clickAction = {
            self.performSegueWithIdentifier("showComment", sender: nil)
        }
        return inputBar
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 44
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(albumZanCellIdentifier, forIndexPath: indexPath)
            if let button = cell.accessoryView as? UIButton {
                button.addTarget(self, action: #selector(AlbumDetailController.zan(_:)), forControlEvents: .TouchUpInside)
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(albumCommentCellIdentifier, forIndexPath: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            let c = cell as! AlbumZanCell
            var zlist = String()
            if let zanlist = albumDetail?.zanList {
                for z in zanlist {
                    if let userName = z.userName {
                        if zlist.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
                            zlist = userName
                        }else {
                            zlist = zlist + (",\(userName)")
                        }
                    }
                }
            }
            c.zanList.text = zlist
            break;
        case 1:
            let c = cell as! AlbumCommentCell
            if let comment = albumDetail?.commentList![indexPath.row] {
                c.name.text = comment.userId
                c.content.text = comment.content
            }
        default:
            break;
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! AlbumCommentController
        vc.albumDetail = albumDetail
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

extension AlbumDetailController: UIWebViewDelegate {
    func webViewDidFinishLoad(webView: UIWebView) {
//        webHeader.frame.size = webHeader.scrollView.contentSize
        webHeader.frame.size = webHeader.sizeThatFits(CGSizeZero)
        tableView.reloadData()
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
}
