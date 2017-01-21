//
//  HeaderReusableView.swift
//  SwiftTest
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

//设置代理
protocol HeaderReusableViewDelegate:NSObjectProtocol {
     func headerReusableViewClicked(info:ProgramList) -> ()
     func reusableViewClicked(section:Int) -> ()
}

class HeaderReusableView: UICollectionReusableView {
    
    var nameLabel:UILabel = UILabel()
    var moreLabel:UILabel = UILabel()
    var moreImageView:UIImageView = UIImageView()
    
    var moreButton:UIButton = UIButton()
    
    var programInfo:ProgramList = ProgramList()
    var section:Int = 0
    
    
    public var headerDelegate:HeaderReusableViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nameLabel.frame = CGRect.init(x: 10, y: 15, width: 100, height: 20)
        nameLabel.textColor = UIColor.gray
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(nameLabel)
        
        moreLabel.frame = CGRect.init(x: self.frame.size.width - 100, y: 15, width:82, height: 20)
        moreLabel.textColor = UIColor.init(colorLiteralRed: 53 / 255.0, green: 53 / 255.0, blue: 53 / 255.0, alpha: 1.0)
        moreLabel.font = UIFont.systemFont(ofSize: 12)
        moreLabel.text = "更多"
        moreLabel.textAlignment = NSTextAlignment.right
        self.addSubview(moreLabel)
        
        moreImageView.frame = CGRect.init(x: self.frame.size.width - 15, y: 20, width: 5, height: 10)
        moreImageView.image = UIImage.init(named: "Common_Image_accessory.png")
        self.addSubview(moreImageView)
        
        moreButton.frame = CGRect.init(x: self.frame.size.width - 100, y: 0, width: 100, height: self.frame.size.height)
        moreButton.addTarget(self, action: #selector(self.buttonClick(button:)), for: UIControlEvents.touchUpInside)
        self.addSubview(moreButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func loadData(info:ProgramList){
        programInfo = info
        if info.layout == 0 || info.layout == 3 {
            if info.name != nil {
                nameLabel.text = info.name
            }
            nameLabel.isHidden = false
            moreImageView.isHidden = false
            moreLabel.isHidden = false
        }else{
            nameLabel.isHidden = true
            moreImageView.isHidden = true
            moreLabel.isHidden = true
        }
        
    }
    
    public func loadDataWithInfo(info:RadioListDeatil){
        
        if info.name != nil {
            nameLabel.text = info.name
        }
        nameLabel.isHidden = false
        moreImageView.isHidden = false
        moreLabel.isHidden = false
        
        self.backgroundColor = UIColor.white
    }
    
    
    func buttonClick(button:UIButton) -> () {
        //设置代理返回
        if self.headerDelegate != nil{
            self.headerDelegate?.headerReusableViewClicked(info: programInfo)
            
            self.headerDelegate?.reusableViewClicked(section: section)
        }
    }
    
    
}
