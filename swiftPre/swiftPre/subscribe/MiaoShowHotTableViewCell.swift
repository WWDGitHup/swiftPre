//
//  MiaoShowHotTableViewCell.swift
//  swiftPre
//
//  Created by apple on 2017/1/23.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit

class MiaoShowHotTableViewCell: UITableViewCell {

    let headImageView:UIImageView = UIImageView()
    let contentImageView:UIImageView = UIImageView()
    let titleLabel:UILabel = UILabel()
    let onlineLabel:UILabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(headImageView)
        headImageView.layer.cornerRadius = 30
        headImageView.clipsToBounds = true
        headImageView.snp.makeConstraints { (snpMake) in
            snpMake.left.top.equalTo(self).offset(10)
            snpMake.height.width.equalTo(60)
        }
        
        addSubview(contentImageView)
        contentImageView.snp.makeConstraints { (snpMake) in
            snpMake.left.right.equalTo(self)
            snpMake.top.equalTo(headImageView.snp.bottom).offset(5)
            snpMake.height.equalTo(ScreenWidth)
        }
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (snpMake) in
            snpMake.left.equalTo(headImageView.snp.right).offset(20)
            snpMake.top.equalTo(headImageView)
            snpMake.height.equalTo(headImageView)
            snpMake.width.equalTo(200)
        }
        
        onlineLabel.textColor = UIColor.darkGray
        onlineLabel.font = UIFont.systemFont(ofSize: 10)
        addSubview(onlineLabel)
        onlineLabel.snp.makeConstraints { (snpMake) in
            snpMake.right.equalTo(self).offset(-20)
            snpMake.top.equalTo(headImageView).offset(20)
            snpMake.height.equalTo(20)
            snpMake.width.equalTo(80)
        }
        
        
        
        
    }
    
    func loadCellData(info:VideoLiveInfo) {
        titleLabel.text = info.myname
        onlineLabel.text = "\(info.allnum!)在线"
        contentImageView.sd_setImage(with: URL.init(string: info.bigpic!))
        headImageView.sd_setImage(with: URL.init(string: info.smallpic!))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
