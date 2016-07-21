//
//  AlbumZanCell.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/5/4.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

class AlbumZanCell: UITableViewCell {
//    @IBOutlet weak var zanList: UILabel!
    var zanList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let button = UIButton(frame: CGRectMake(0, 0, 30, 30))
        button.setImage(UIImage(named: "like_normal"), forState: .Normal)
        button.setImage(UIImage(named: "like_selected"), forState: .Highlighted)
        button.setImage(UIImage(named: "like_selected"), forState: .Selected)
        accessoryView = button
        
        zanList = UILabel()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
