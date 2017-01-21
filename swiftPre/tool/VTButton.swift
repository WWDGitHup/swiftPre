//
//  VTButton.swift
//  swiftPre
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit

class VTButton: UIButton {

    
    var tImageView:UIImageView = UIImageView()
    var tTitleLabel:UILabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tImageView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height)
        self.addSubview(tImageView)
        tTitleLabel.frame = CGRect.init(x: tImageView.frame.size.width, y: 0, width: self.frame.size.width - self.frame.size.height, height: self.frame.size.height)
        tTitleLabel.font = UIFont.systemFont(ofSize: 12)
        tTitleLabel.textColor = UIColor.darkGray
        self.addSubview(tTitleLabel)
    }
    
    
    func setTTitleLabelText(text:String){
        tTitleLabel.text = text
    }
    
    
    func setTimageViewImage(image:UIImage) {
        tImageView.image = image
    }
    
    func setImageViewFrame(frame:CGRect) {
        tImageView.frame = frame
        
        tTitleLabel.frame = CGRect.init(x: tImageView.frame.size.width + tImageView.frame.origin.x + 3, y: 0, width: self.frame.size.width - tImageView.frame.size.width, height: self.frame.size.height)
    }
    
    func setFrame(frame:CGRect) {
        self.frame = frame
        tImageView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height)
        tTitleLabel.frame = CGRect.init(x: tImageView.frame.size.width, y: 0, width: self.frame.size.width - self.frame.size.height, height: self.frame.size.height)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
