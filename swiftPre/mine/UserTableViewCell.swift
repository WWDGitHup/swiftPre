//
//  UserTableViewCell.swift
//  swiftPre
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var headImageView = UIImageView()
    var headLabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(headImageView)
        headLabel.font = UIFont.systemFont(ofSize: 15)
        headLabel.textColor = UIColor.darkGray
        self.addSubview(headLabel)
        headImageView.snp.makeConstraints { (snpMake) in
            snpMake.left.equalTo(self).offset(20)
            snpMake.centerY.equalTo(self)
            snpMake.width.equalTo(20)
            snpMake.height.equalTo(20)
        }
        
        
        headLabel.snp.makeConstraints { (snpMake) in
            snpMake.left.equalTo(headImageView.snp.right).offset(20)
            snpMake.centerY.equalTo(headImageView)
            snpMake.width.equalTo(200)
            snpMake.height.equalTo(headImageView)
        }
 
    }
    
    
    func loadUserData(dictory:Dictionary<String,String>) {
        
        headImageView.image = UIImage.init(named: dictory["image"]!)
        headLabel.text = dictory["title"]
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
