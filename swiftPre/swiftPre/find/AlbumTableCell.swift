//
//  AlbumTableCell.swift
//  SwiftTest
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import SDWebImage

class AlbumTableCell: UITableViewCell{

    let headImageView:UIImageView = UIImageView()
    
    let titleLabel:UILabel = UILabel()
    
    let detailLabel:UILabel = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headImageView.frame = CGRect.init(x: 20, y: 5, width: 70, height: 70)
        self.addSubview(headImageView)
        
        titleLabel.frame = CGRect.init(x: headImageView.frame.origin.x + headImageView.frame.size.width + 10 , y: headImageView.frame.origin.y + 10, width: ScreenWidth - (headImageView.frame.origin.x + headImageView.frame.size.width + 40), height: 20)
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UIColor.darkGray
        self.addSubview(titleLabel)
        
        detailLabel.frame = CGRect.init(x: headImageView.frame.origin.x + headImageView.frame.size.width + 10 , y: titleLabel.frame.origin.y + 5 + titleLabel.frame.size.height, width: ScreenWidth - (headImageView.frame.origin.x + headImageView.frame.size.width + 40), height: 40)
        detailLabel.font = UIFont.systemFont(ofSize: 11)
        detailLabel.textColor = UIColor.init(red: 153 / 255.0, green: 153 / 255.0, blue: 153 / 255.0, alpha: 1.0)
        detailLabel.numberOfLines = 2
        self.addSubview(detailLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadData(info:SongInfo) {
        if info.logoUrl !=  nil {
            headImageView.sd_setImage(with: URL.init(string: info.logoUrl!))
        }
        
        titleLabel.text = info.name
    }
    
    
    func loadRadioDetailData(info:SectionDetailsModel) {
        
        if info.cover !=  nil {
            headImageView.sd_setImage(with: URL.init(string: info.cover!))
        }
        titleLabel.text = info.name
        detailLabel.text = info.descriptions
        
    }
}

extension AlbumTableCell{

    
}





