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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let request = NSURLRequest(URL: NSURL(string: "http://www.crossd.me")!, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 10)
        webHeader.loadRequest(request)
        webHeader.scrollView.scrollEnabled = false
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib(nibName: albumZanCellIdentifier, bundle: nil), forCellReuseIdentifier: albumZanCellIdentifier)
        tableView.registerNib(UINib(nibName: albumCommentCellIdentifier, bundle: nil), forCellReuseIdentifier: albumCommentCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            return 3
        default:
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(albumZanCellIdentifier, forIndexPath: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(albumCommentCellIdentifier, forIndexPath: indexPath)
            return cell
        default:
            return UITableViewCell()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
