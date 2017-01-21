//
//  MoreAlbumList.swift
//  SwiftTest
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class MoreAlbumList: NSObject {

    
    var count:Int = 0
    var currentPage:Int = 0
    var perPage:Int = 0
    var totalPage:Int = 0
    var con:Array<AnyObject>?
    
    func analyzeMoreAlbumList(dictory:Dictionary<String,AnyObject>) -> MoreAlbumList {
        
        self.count = dictory["count"] as! Int
        self.currentPage = dictory["currentPage"] as! Int
        self.perPage = dictory["perPage"] as! Int
        self.totalPage = dictory["totalPage"] as! Int
        
        if dictory["con"] != nil {
            let albu = dictory["con"]
            if albu != nil {
                if (albu?.isKind(of: NSNull.self))! {
                    
                }else{
                    let album:[AnyObject] = (albu as? Array)!
                    var albumArray:[AlbumDetail] = Array()
                    for object in album {
                        let obj = object as! Dictionary<String,AnyObject>
                        let albumInfo:AlbumDetail = AlbumDetail().analyzeAlbumDetail(dictory: obj)
                        albumArray.append(albumInfo)
                    }
                    self.con = albumArray
                }
            }
            

        }
        
        return self
    }
    
}
