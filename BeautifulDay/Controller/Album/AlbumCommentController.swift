//
//  AlbumCommentController.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/5/30.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit
import SlackTextViewController

private let albumZanCellIdentifier = "AlbumZanCell"
private let albumCommentCellIdentifier = "AlbumCommentCell"

class AlbumCommentController: SLKTextViewController {
    
    var pipWindow: UIWindow?
    
    var albumDetail: AlbumDetail? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    override class func tableViewStyleForCoder(decoder: NSCoder) -> UITableViewStyle {
        return .Plain
    }
    
    func commonInit() {
        
        NSNotificationCenter.defaultCenter().addObserver(self.tableView!, selector: #selector(UITableView.reloadData), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,  selector: #selector(AlbumCommentController.textInputbarDidMove(_:)), name: SLKTextInputbarDidMoveNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        
        tableView?.estimatedRowHeight = 44
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.registerNib(UINib(nibName: albumCommentCellIdentifier,bundle: nil), forCellReuseIdentifier: albumCommentCellIdentifier)
        tableView?.registerNib(UINib(nibName: albumZanCellIdentifier,bundle: nil), forCellReuseIdentifier: albumZanCellIdentifier)
        
        
        // SLKTVC's configuration
        self.bounces = true
        self.shakeToClearEnabled = true
        self.keyboardPanningEnabled = true
        self.shouldScrollToBottomAfterKeyboardShows = false
        self.inverted = false
        
        self.textInputbar.autoHideRightButton = true
        self.textInputbar.maxCharCount = 256
        self.textInputbar.counterStyle = .Split
        self.textInputbar.counterPosition = .Top
        
        self.textInputbar.editorTitle.textColor = UIColor.darkGrayColor()
        self.textInputbar.editorLeftButton.tintColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        self.textInputbar.editorRightButton.tintColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        
        //        self.autoCompletionView.registerClass(MessageTableViewCell.classForCoder(), forCellReuseIdentifier: AutoCompletionCellIdentifier)
        self.registerPrefixesForAutoCompletion(["@",  "#", ":", "+:", "/"])
        
        self.textView.registerMarkdownFormattingSymbol("*", withTitle: "Bold")
        self.textView.registerMarkdownFormattingSymbol("_", withTitle: "Italics")
        self.textView.registerMarkdownFormattingSymbol("~", withTitle: "Strike")
        self.textView.registerMarkdownFormattingSymbol("`", withTitle: "Code")
        self.textView.registerMarkdownFormattingSymbol("```", withTitle: "Preformatted")
        self.textView.registerMarkdownFormattingSymbol(">", withTitle: "Quote")
        
    }

    // MARK: - Action
    @objc func zan(sender: UIButton) {
        sender.selected = !sender.selected
        let keyframeAni = CAKeyframeAnimation(keyPath: "transform.scale")
        keyframeAni.duration = 0.5;
        keyframeAni.values = [0.1, 1.5, 1.0];
        keyframeAni.keyTimes = [0, 0.8, 1];
        keyframeAni.calculationMode = kCAAnimationLinear;
        sender.layer.addAnimation(keyframeAni, forKey: "zan")
        zanAction(sender.selected)
    }
    
    private func zanAction(status: Bool) {
        // todo
        postZan(albumDetail!.albuminfo!.albumId!, zanStatus: status, failure: { (error) in
            print("zan failure")
            SAIUtil.showMsg("点赞失败")
            }, success:{ (z) in
                print("zan success")
                
        })
    }
    
    func textInputbarDidMove(note: NSNotification) {
        
        guard let pipWindow = self.pipWindow else {
            return
        }
        
        guard let userInfo = note.userInfo else {
            return
        }
        
        guard let value = userInfo["origin"] as? NSValue else {
            return
        }
        
        var frame = pipWindow.frame
        frame.origin.y = value.CGPointValue().y - 60.0
        
        pipWindow.frame = frame
    }
    
    override func didPressRightButton(sender: AnyObject!) {
        
        // This little trick validates any pending auto-correction or auto-spelling just after hitting the 'Send' button
        self.textView.resignFirstResponder()
        postComment((albumDetail?.albuminfo?.albumId)!, content: textView.text, failure: { (error) in
            print("comment fail: \(error.description)")
        }) { [weak self](comment) in
            guard let weakSelf = self else {
                return
            }
            let indexPath = NSIndexPath(forRow: 0, inSection: 1)
            let rowAnimation: UITableViewRowAnimation = weakSelf.inverted ? .Bottom : .Top
            let scrollPosition: UITableViewScrollPosition = weakSelf.inverted ? .Bottom : .Top
            dispatch_async(dispatch_get_main_queue(), {
                weakSelf.tableView!.beginUpdates()
                weakSelf.albumDetail?.commentList?.insert(comment, atIndex: 0)
                weakSelf.tableView!.insertRowsAtIndexPaths([indexPath], withRowAnimation: rowAnimation)
                weakSelf.tableView!.endUpdates()
                
                weakSelf.tableView!.scrollToRowAtIndexPath(indexPath, atScrollPosition: scrollPosition, animated: true)
                
                weakSelf.tableView!.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
        }
        super.didPressRightButton(sender)
    }
    
    // MARK: - UITableView
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
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header = UILabel();
            header.backgroundColor = UIColor.lightGrayColor()
            header.text = "喜欢"
            return header
        case 1:
            let header = UILabel();
            header.backgroundColor = UIColor.lightGrayColor()
            header.text = "评论"
            return header
        default:
            return nil
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(albumZanCellIdentifier, forIndexPath: indexPath)
            if let button = cell.accessoryView as? UIButton {
                button.addTarget(self, action: #selector(AlbumCommentController.zan(_:)), forControlEvents: .TouchUpInside)
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
        cell.transform = tableView.transform
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
            if zlist.isEmpty {
                zlist = "还没人点赞，赶紧点赞吧！"
            }
            c.zanList.text = zlist
            break;
        case 1:
            let c = cell as! AlbumCommentCell
            if let comment = albumDetail?.commentList![indexPath.row] {
                // todo
//                c.name.text = comment.
                c.content.text = comment.content
            }
        default:
            break;
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    //    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return 100
    //    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
