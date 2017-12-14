//
//  RadioDetailCell.swift
//  swiftPre
//
//  Created by apple on 2017/1/6.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit

class RadioDetailCell: UICollectionViewCell {
    
    let headImageView = UIImageView()
    let titleLabel = UILabel()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headImageView)
        headImageView.snp.makeConstraints { (snpMake) in
            snpMake.top.left.equalTo(self).offset(5)
            snpMake.right.bottom.equalTo(self).offset(-5)
        }
        headImageView.backgroundColor = UIColor.clear
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (snpMake) in
            snpMake.top.left.equalTo(headImageView)
            snpMake.right.equalTo(headImageView)
            snpMake.height.equalTo(20)
        }
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 8)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadDataImage(info:AnchorpersonModel) {
        if info.logo != nil {
            headImageView.sd_setImage(with: URL.init(string: info.logo!))
        }else{
            headImageView.sd_setImage(with: URL.init(string: "http://i2.hdslb.com/video/63/63f122b740a6df2b61581f81fe070a04.jpg"))
        }
        titleLabel.text = info.name
    }
}
