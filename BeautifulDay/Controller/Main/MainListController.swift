//
//  MainListController.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/5/3.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

private let mainListCellIdentifier = "MainListCell"
private let loadMoreTableCellIdentifier = "LoadMoreTableCell"

class MainListController: UITableViewController {
    var trk : Track? = nil
    var albumList = Array<Album>()
    
    let activityIndicator = UIActivityIndicatorView()
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(MainListController.refresh(_:)), forControlEvents: .ValueChanged)
        refreshControl = rc
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.pagingEnabled = true
        tableView.registerNib(UINib(nibName: mainListCellIdentifier, bundle: nil), forCellReuseIdentifier: mainListCellIdentifier)
        tableView.registerNib(UINib(nibName: loadMoreTableCellIdentifier, bundle:nil), forCellReuseIdentifier: loadMoreTableCellIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if albumList.isEmpty {
            refresh(refreshControl!)
            refreshControl?.beginRefreshing()
        }
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.translucentBar()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //        self.navigationController?.navigationBar.opaqueBar()
    }
    
    
    // MARK: - Refresh
    @objc private func refresh(sender: UIRefreshControl) {
        
        updateDiscoverUsers(mode: .TopRefresh) {
            dispatch_async(dispatch_get_main_queue()) {
                sender.endRefreshing()
            }
        }
    }
    
    private var currentPageIndex = 0
    private var isFetching = false
    private enum UpdateMode {
        case Static
        case TopRefresh
        case LoadMore
    }
    private func updateDiscoverUsers(mode mode: UpdateMode, finish: (() -> Void)? = nil) {
        
        if isFetching {
            return
        }
        
        isFetching = true
        
        if case .Static = mode {
            activityIndicator.startAnimating()
            view.bringSubviewToFront(activityIndicator)
        }
        
        if case .LoadMore = mode {
            currentPageIndex += 1
            
        } else {
            currentPageIndex = 1
        }
        
        // todo 根据updateMode的区别来做不同的事情
        fetchAlbumList({ (error) in
            print(error.description)
        }) { (success, albumList) in
            dispatch_async(dispatch_get_main_queue(), {[weak self] in
                self?.albumList = albumList
                self?.tableView.reloadData()
                self?.isFetching = false
                finish?()
                })
        }
        //        discoverUsers(masterSkillIDs: [], learningSkillIDs: [], discoveredUserSortStyle: discoveredUserSortStyle, inPage: currentPageIndex, withPerPage: 21, failureHandler: { (reason, errorMessage) in
        //            defaultFailureHandler(reason: reason, errorMessage: errorMessage)
        //
        //            dispatch_async(dispatch_get_main_queue()) { [weak self] in
        //                self?.activityIndicator.stopAnimating()
        //                self?.isFetching = false
        //
        //                finish?()
        //            }
        //
        //            }, completion: { discoveredUsers in
        //
        //                for user in discoveredUsers {
        //
        //                    for skill in user.masterSkills {
        //
        //                        let skillLocalName = skill.localName ?? ""
        //
        //                        let skillID =  skill.id
        //
        //                        if let _ = skillSizeCache[skillID] {
        //
        //                        } else {
        //                            let rect = skillLocalName.boundingRectWithSize(CGSize(width: CGFloat(FLT_MAX), height: SkillCell.height), options: [.UsesLineFragmentOrigin, .UsesFontLeading], attributes: skillTextAttributes, context: nil)
        //
        //                            skillSizeCache[skillID] = rect
        //                        }
        //                    }
        //                }
        //
        //                dispatch_async(dispatch_get_main_queue()) { [weak self] in
        //
        //                    guard let strongSelf = self else {
        //                        return
        //                    }
        //
        //                    var wayToUpdate: UICollectionView.WayToUpdate = .None
        //
        //                    if case .LoadMore = mode {
        //                        let oldDiscoveredUsersCount = strongSelf.discoveredUsers.count
        //                        strongSelf.discoveredUsers += discoveredUsers
        //                        let newDiscoveredUsersCount = strongSelf.discoveredUsers.count
        //
        //                        let indexPaths = Array(oldDiscoveredUsersCount..<newDiscoveredUsersCount).map({ NSIndexPath(forItem: $0, inSection: Section.User.rawValue) })
        //                        if !indexPaths.isEmpty {
        //                            wayToUpdate = .Insert(indexPaths)
        //                        }
        //
        //                    } else {
        //                        strongSelf.discoveredUsers = discoveredUsers
        //                        wayToUpdate = .ReloadData
        //                    }
        //
        //                    strongSelf.activityIndicator.stopAnimating()
        //                    strongSelf.isFetching = false
        //
        //                    finish?()
        //
        //                    wayToUpdate.performWithCollectionView(strongSelf.discoveredUsersCollectionView)
        //                }
        //        })
    }
    
    // MARK: - Table view data source
    private enum Section: Int {
        case Normal
        case LoadMore
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.Normal.rawValue:
            return albumList.count
        case Section.LoadMore.rawValue:
            return albumList.isEmpty ? 0 : 1
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.Normal.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier(mainListCellIdentifier, forIndexPath: indexPath) as! MainListCell
            return cell
        case Section.LoadMore.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier(loadMoreTableCellIdentifier, forIndexPath: indexPath) as! LoadMoreTableCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case Section.Normal.rawValue:
            return tableView.bounds.height
        case Section.LoadMore.rawValue:
            return 44
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case Section.Normal.rawValue:
            if let cell = cell as? MainListCell {
                cell.album = albumList[indexPath.row]
            }
        case Section.LoadMore.rawValue:
            if let cell = cell as? LoadMoreTableCell {
                print("load more data")
                if !cell.loadingActivityIndicator.isAnimating() {
                    cell.loadingActivityIndicator.startAnimating()
                }
                updateDiscoverUsers(mode: .LoadMore, finish: {[weak cell] in
                    cell?.loadingActivityIndicator.stopAnimating()
                    })
            }
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // todo: sender should be something to pass
        performSegueWithIdentifier("showAlbumDetail", sender: nil)
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
