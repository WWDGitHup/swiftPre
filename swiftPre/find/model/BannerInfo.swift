//
//  BannerInfo.swift
//  SwiftTest
//
//  Created by apple on 2016/12/22.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class BannerInfo: NSObject {
    var url:String?
    var linkType:String?
    var objectId:String?
    var title:String?
    var columnId:String?
    

    public func analyzeBannerInfo(dictory:Dictionary<String,AnyObject>) -> BannerInfo {
        
        if let urlOb = dictory["url"]{
            self.url = urlOb as? String
        }
        
        if let linkT = dictory["linkType"]{
            self.linkType = linkT as? String
        }
        
        if let oId = dictory["id"] {
            self.objectId = oId  as? String
        }
        
        if let name = dictory["title"] {
            self.title = name as? String
        }
        
        if let cId = dictory["columnId"] {
            self.columnId = cId as? String
        }
        return self
    }
}
