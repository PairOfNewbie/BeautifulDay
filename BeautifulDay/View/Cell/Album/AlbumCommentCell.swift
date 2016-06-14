//
//  AlbumCommentCell.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/5/4.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

class AlbumCommentCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var time: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let imageName = "\(arc4random_uniform(UInt32(10)))"
        avatar.image = UIImage(named: imageName)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
