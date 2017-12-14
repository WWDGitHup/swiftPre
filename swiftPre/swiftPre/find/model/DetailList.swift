//
//  DetailList.swift
//  SwiftTest
//
//  Created by apple on 2016/12/22.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class DetailList: NSObject {
    var albumId:Int = 0
//    var anchorpersonList:String?
    var clickCount = 0
    var createTime:String?
    var commentCount = 0
    var descriptions:String?
    var endTime:String?
    var objectId = 0
    var linkType = 0
    var linkUrl:String?
    var logo:String?
    var name:String?
    var playUrl:String?
    var userNames:String?
    var videoLogo:String?
    var type:String?
    var videoType = 0
    
    public func anylyzeDetailInfo(dictory:Dictionary<String,AnyObject>) -> DetailList{
        if let aId = dictory["albumId"] {
            if aId.isKind(of: NSNull.self) {
                
            }else{
                self.albumId = aId as! Int
            }
            
        }
        self.clickCount = dictory["clickCount"] as! Int
        if let cTim = dictory["createTime"] {
            self.createTime = cTim as? String
        }
        self.commentCount = dictory["commentCount"] as! Int
        if let descri = dictory["descriptions"] {
            self.descriptions = descri as? String
        }
        if let endT = dictory["endTime"] {
            self.endTime = endT as? String
        }
        self.objectId = dictory["id"] as! Int
        self.linkType = dictory["linkType"] as! Int
        
        if let lUrl = dictory["linkUrl"] {
            self.linkUrl = lUrl as? String
        }
        if let lo = dictory["logo"] {
            self.logo = lo as? String
        }
        
        if let na = dictory["name"] {
            self.name = na as? String
        }
        if let pla = dictory["playUrl"] {
            self.playUrl = pla as? String
        }
        if let una = dictory["userNames"] {
            self.userNames = una as? String
        }
        if let vlo = dictory["videoLogo"] {
            self.videoLogo = vlo as? String
        }
        
        if let typ = dictory["type"] {
            self.type = typ as? String
        }
        self.videoType = dictory["videoType"] as! Int
        return self
    }
    
    
}
