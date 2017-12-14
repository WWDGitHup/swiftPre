//
//  AnchoVideoCell.swift
//  SwiftTest
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class AnchoVideoCell: UICollectionViewCell {
    
    var headImageView:UIImageView = UIImageView()
    var nameLabel:UILabel = UILabel()
    var introduceLabel:UILabel = UILabel()
    var onlieLabel:UILabel = UILabel()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headImageView.frame = CGRect.init(x: 10, y: 5, width: self.frame.size.width - 20, height: 150)
        headImageView.contentMode = UIViewContentMode.scaleAspectFill
        headImageView.clipsToBounds = true
        self.addSubview(headImageView)
        
        
        nameLabel.frame = CGRect.init(x: headImageView.frame.origin.x + 10, y: headImageView.frame.size.height + headImageView.frame.origin.y + 5, width: 200, height: 15)
        nameLabel.textColor = UIColor.init(red: 53 / 255.0, green: 53 / 255.0, blue: 53 / 255.0, alpha: 1.0)
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(nameLabel)
        
        onlieLabel.frame = CGRect.init(x: headImageView.frame.origin.x  + headImageView.frame.size.width - 100, y: headImageView.frame.size.height + headImageView.frame.origin.y + 5, width: 95, height: 15)
        onlieLabel.textColor = UIColor.darkGray
        onlieLabel.font = UIFont.systemFont(ofSize: 11)
        onlieLabel.textAlignment = NSTextAlignment.right
        self.addSubview(onlieLabel)
        
        introduceLabel.frame = CGRect.init(x: headImageView.frame.origin.x + 10, y: nameLabel.frame.size.height + nameLabel.frame.origin.y, width: headImageView.frame.size.width - 25, height: 20)
        introduceLabel.textColor = UIColor.darkGray
        introduceLabel.font = UIFont.systemFont(ofSize: 11)
        self.addSubview(introduceLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func loadData(program:ProgramList){
        if program.detailList.count > 0{
            let detail:DetailList = program.detailList[0]
            self.headImageView.sd_setImage(with: URL.init(string: detail.logo!))
            self.nameLabel.text = detail.name
            self.onlieLabel.text = String.init(format: "%d人在线", detail.clickCount)
            self.introduceLabel.text = detail.descriptions
            
        }
        
        
        
    }
    
    
    
    
}
