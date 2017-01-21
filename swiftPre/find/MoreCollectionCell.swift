//
//  MoreCollectionCell.swift
//  SwiftTest
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class MoreCollectionCell: UICollectionViewCell {
    var headImageView:UIImageView = UIImageView()
    var titleLabel:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headImageView.backgroundColor = UIColor.red
        self.addSubview(headImageView)
        
        
        titleLabel.font = UIFont.systemFont(ofSize: 11)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.numberOfLines = 2
        self.addSubview(titleLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadData(info:AlbumDetail,indexPath:IndexPath) -> () {
        
        //加载图片
        if info.logo != nil {
            self.headImageView.sd_setImage(with: URL.init(string:info.logo!))
        }
        

            //计算字符串的高度
        let index = indexPath.row % 3
        
            
        switch index {
        case 0:
            headImageView.frame = CGRect.init(x: 10, y: 5, width: self.frame.size.width - 10, height: self.frame.size.width - 10 )
            
            break
            
        case 1:
            headImageView.frame = CGRect.init(x: 5, y: 5, width: self.frame.size.width - 10, height: self.frame.size.width - 10)
            
            break
        case 2:
            headImageView.frame = CGRect.init(x: 0, y: 5, width: self.frame.size.width - 10, height: self.frame.size.width - 10)
            
            break
        default:
            break
            
        }
        
        let height:CGFloat = 30
        if info.albumName != nil {
            titleLabel.text = info.albumName
            
            titleLabel.frame = CGRect.init(x: self.headImageView.frame.origin.x, y: self.headImageView.frame.origin.y + self.headImageView.frame.size.height + 5, width: self.headImageView.frame.size.width, height: height)
        }
    }

        
        
    
}
