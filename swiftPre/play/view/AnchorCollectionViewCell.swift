//
//  AnchorCollectionViewCell.swift
//  SwiftTest
//
//  Created by Victor on 2016/12/20.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class AnchorCollectionViewCell: UICollectionViewCell {
    
    let imageView:UIImageView = UIImageView()
    let titleLabel:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.width - 18)
        self.addSubview(imageView)
        
        titleLabel.frame = CGRect.init(x: 0, y: self.frame.size.width - 18, width: self.frame.size.width, height: 40)
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UIColor.red
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.numberOfLines = 2
        self.addSubview(titleLabel)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     public func setCollectionViewCellData(anchor:AnchorList)  {
        
        self.imageView.sd_setImage(with: URL.init(string: anchor.middleLogo!))
        self.titleLabel.text = anchor.personDescribe
    }
    
    
    
    
    
}
