//
//  AlbumInfo.swift
//  SwiftTest
//
//  Created by Victor on 2016/12/23.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class AlbumInfo: NSObject {

    var anchorpersons:String?
    var collect:String?
    var columnId:String?
    var columnName:String?
    var con:Array<AnyObject>?
    var count:Int = 0
    var descriptions:String?
    var logoUrl:String?
    var providerName:String?
    var currentPage:Int = 0
    var listenNum:Int = 0
    var totalPage:Int = 0
    var providerCode:Int = 0
    
    func analyzeAlbumInfo(dictory:Dictionary<String,AnyObject>) -> AlbumInfo{
        
        if let anch = dictory["anchorpersons"]{
            self.anchorpersons = anch as? String
        }
        
        if let colle = dictory["collect"]{
            self.collect = colle as? String
        }
        
        if let columnNa = dictory["columnName"] {
            self.columnName = columnNa  as? String
        }
        
        if let descript = dictory["descriptions"] {
            self.descriptions = descript as? String
        }
        
        if let logo = dictory["logoUrl"] {
            self.logoUrl = logo as? String
        }
        if let providerNa = dictory["providerName"] {
            self.providerName = providerNa as? String
        }
        
        if let columnI = dictory["columnId"] {
            self.columnId = columnI as? String
        }
        
        self.count = dictory["count"] as! Int
        self.currentPage = dictory["currentPage"] as! Int
        self.listenNum = dictory["listenNum"] as! Int
        self.totalPage = dictory["totalPage"] as! Int
        self.providerCode = dictory["providerCode"] as! Int
        
        if dictory["con"] != nil {
            let song:[AnyObject] = (dictory["con"] as? Array)!
            var songArray:[SongInfo] = Array()
            
            for object in song {
                let obj = object as! Dictionary<String,AnyObject>
                let songInfo:SongInfo = SongInfo().analyzeSongInfo(dictory: obj)
                songArray.append(songInfo)
            }
            self.con = songArray
        }
        
        return self
        
    }
    
    deinit {
        print("CarrierSubscription \(con) is being deallocated")
    }
    
}
