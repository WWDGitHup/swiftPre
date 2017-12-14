//
//  AnchorList.swift
//  SwiftTest
//
//  Created by apple on 2016/12/19.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
class AnchorList: NSObject {
    var smallLogo: String?
    
    var uid: Int = 0
    
    var nickname: String?
    
    var isVerified: Bool = false
    
    var middleLogo: String?
    
    var largeLogo: String?
    
    var followersCounts: Int = 0
    
    var verifyTitle: String?
    
    var tracksCounts: Int = 0
    
    var personDescribe: String?
    
    override internal var description: String {
        return "smalllogo : \(self.smallLogo) uid : \(self.uid) nickname : \(self.nickname) middleLogo : \(self.middleLogo) largeLogo : \(self.largeLogo) verifyTitle : \(self.verifyTitle)"
    }
    
    public func anayAnchoList(dictory:AnyObject) -> AnchorList{
        let dictory = dictory as! Dictionary<String,AnyObject>
        self.smallLogo = dictory["smallLogo"] as! String?
        self.uid = dictory["uid"] as! Int
        self.nickname = dictory["nickname"] as! String?
        self.isVerified = (dictory["isVerified"] != nil)
        self.middleLogo = dictory["middleLogo"] as! String?
        self.largeLogo = dictory["largeLogo"] as! String?
        self.followersCounts = dictory["followersCounts"] as! Int
        self.verifyTitle = dictory["verifyTitle"] as! String?
        self.tracksCounts = dictory["tracksCounts"] as! Int
        self.personDescribe = dictory["personDescribe"] as! String?
        return  self
    }
    
    
    
    
}
