//
//  SongInfo.swift
//  SwiftTest
//
//  Created by Victor on 2016/12/23.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class SongInfo: NSObject {
    
    var columnName:String?
    var logoUrl:String?
    var name:String?
    var playUrl:String?
    var providerName:String?
    var duration:String?
    var objectId:String?
    var ifDownload:Int = 0
    var index:Int = 0
    var isCollect:Int = 0
    var listenNum:Int = 0
    var replyNum:Int = 0
    
    var isLive:Bool = false
    

    func analyzeSongInfo(dictory:Dictionary<String,AnyObject>) -> SongInfo
    {
        
        if let columnN = dictory["columnName"] {
            self.columnName = columnN as? String
        }
        if let logoU = dictory["logoUrl"] {
            self.logoUrl = logoU as? String
        }
        
        if let na = dictory["name"] {
            self.name = na as? String
        }
        if let pla = dictory["playUrl"] {
            self.playUrl = pla as? String
        }
        if let provid = dictory["providerName"] {
            self.providerName = provid as? String
        }
        if let dur = dictory["duration"] {
            self.duration = dur as? String
        }
        
        if let objectI = dictory["objectId"] {
            self.objectId = objectI as? String
        }

        
        self.ifDownload = dictory["ifDownload"] as! Int
        self.index = dictory["index"] as! Int
        self.listenNum = dictory["listenNum"] as! Int
        self.isCollect = dictory["isCollect"] as! Int
        self.replyNum = dictory["replyNum"] as! Int
        
        return self
    }

}
