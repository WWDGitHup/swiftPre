//
//  AnchorInfo.swift
//  SwiftTest
//
//  Created by apple on 2016/12/19.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class AnchorInfo: NSObject {
    
    var ID:Int = 0
    var title:String?
    var name:String?
    var displayStyle:Int = 0
    var list: [AnchorList]?
    
    override internal var description: String {
        return "name : \(self.name) ID : \(self.ID) displayStyle : \(self.displayStyle) displayStyle : \(self.displayStyle) list : \(self.list)"
    }
    public func anayAnchorInfo(dictory:AnyObject) -> AnchorInfo{
        let dictory = dictory as! Dictionary<String,AnyObject>
        self.ID = dictory["id"] as! Int
        self.title = dictory["title"] as! String?
        self.displayStyle = dictory["displayStyle"] as! Int
        
        let jsonArray = dictory["list"] as! Array<AnyObject>
        
        var listArray = Array<AnchorList>()
        
        for dicJson in jsonArray {
            let ancholist = AnchorList().anayAnchoList(dictory: dicJson as AnyObject)
            listArray.append(ancholist)

        }
        self.list = listArray
        return self
    }

    
}
