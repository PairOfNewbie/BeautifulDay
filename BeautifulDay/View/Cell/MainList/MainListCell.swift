//
//  MainListCell.swift
//  BeautifulDay
//
//  Created by DaiFengyi on 16/5/3.
//  Copyright © 2016年 PairOfNewbie. All rights reserved.
//

import UIKit
import SnapKit
class MainListCell: UITableViewCell {
    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mpViewContrainer: UIView!
    var mpView: MusicPlayBar!
    
    var album: Album? {
        didSet {
            if let album = self.album {
                if let imgUrl = album.imgUrl {
                    bgView.sd_setImageWithURL(NSURL(string: imgUrl), placeholderImage: nil, options: .RetryFailed)
                }
                
//                let shadow = NSShadow()
//                shadow.shadowColor = UIColor.grayColor()
//                shadow.shadowOffset = CGSizeMake(1, 1)
                
                let at = NSAttributedString(string: album.date!, attributes: [NSFontAttributeName : UIFont(name: "HelveticaNeue-UltraLight", size: 60)!])
                dateLabel.attributedText = at
                descriptionLabel.text = album.text
                let trk = Track()
                trk.artist = album.text
                trk.title = album.text
                if let musicUrl = album.musicUrl {
                    trk.audioFileURL = NSURL(string: musicUrl)
                }
                mpView.trk = trk
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mpView = NSBundle.mainBundle().loadNibNamed("MusicPlayBar", owner: self, options: nil).last as! MusicPlayBar
        mpViewContrainer.addSubview(mpView)
        mpView.snp_makeConstraints { [unowned self](make) in
            make.edges.equalTo(self.mpViewContrainer)
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
