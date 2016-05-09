//
//  AlbumListCell.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/5/9.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit

class AlbumListCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var summary: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
