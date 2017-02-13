//
//  CommonThreeCell.swift
//  SwiftTest
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

//三列view
class CommonThreeCell: UICollectionViewCell {
    
    
    var headImageView:UIImageView = UIImageView()
    var titleLabel:UILabel = UILabel()
    var typeLabel:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.addSubview(headImageView)
        

        titleLabel.font = UIFont.systemFont(ofSize: 11)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.numberOfLines = 2
        self.addSubview(titleLabel)
        
        typeLabel.font = UIFont.systemFont(ofSize: 10)
        typeLabel.textColor = UIColor.init(red: 202 / 255.0, green: 202 / 255.0, blue: 202 / 255.0, alpha: 1.0)
        self.addSubview(typeLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CommonThreeCell{
    func loadDataSetFrame(info:DetailList,indexPath:IndexPath,layout:Int) -> () {
        
        //加载图片
        if info.logo != nil {
           self.headImageView.sd_setImage(with: URL.init(string:info.logo!))
        }
        
        if layout == 3 {
            let index = indexPath.row % 2
            if index == 0 {
                headImageView.frame = CGRect.init(x: 10, y: 5, width: self.frame.size.width - 15, height: (self.frame.size.width - 10) * 3 / 5)
            }else{
                headImageView.frame = CGRect.init(x: 5, y: 5, width: self.frame.size.width - 15, height: (self.frame.size.width - 10) * 3 / 5)
            }
            
        }else if layout == 0
        {
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
        }
        var height:CGFloat = 0
        if info.descriptions != nil {
            height = info.descriptions!.getStringHeight(font:UIFont.systemFont(ofSize: 11),limitWidth: headImageView.frame.size.width)
            if height > 30 {
                height = 30
            }
            titleLabel.text = info.descriptions
            
            titleLabel.frame = CGRect.init(x: self.headImageView.frame.origin.x, y: self.headImageView.frame.origin.y + self.headImageView.frame.size.height + 5, width: self.headImageView.frame.size.width, height: height)
        }
        if info.name != nil {
            typeLabel.text = info.name
            typeLabel.frame = CGRect.init(x: self.titleLabel.frame.origin.x, y: self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height , width: self.titleLabel.frame.size.width, height: 15)
            
        }
        
        
    }
    
    
    
}














