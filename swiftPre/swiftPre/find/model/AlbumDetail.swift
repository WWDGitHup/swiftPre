//
//  AlbumDetail.swift
//  SwiftTest
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class AlbumDetail: NSObject {

    var albumId:Int = 0
    var albumName:String?
    var dDate:String?
    var logo:String?
    var providerName:String?
    var atypeId:Int = 0
    var objectId:Int = 0
    var providerId:Int = 0
    
    func analyzeAlbumDetail(dictory:Dictionary<String,AnyObject>) -> AlbumDetail {
        self.albumId  = dictory["albumId"] as! Int
        self.atypeId = dictory["atypeId"] as! Int
        self.objectId = dictory["id"] as! Int
        self.providerId = dictory["providerId"] as! Int
        if let albumNa = dictory["albumName"]{
            self.albumName = albumNa as? String
        }
        
        if let dDa = dictory["dDate"]{
            self.dDate = dDa as? String
        }
        
        if let loo = dictory["logo"] {
            self.logo = loo as? String
            
        }
        if let providerNa = dictory["providerName"] {
            self.providerName = providerNa as? String
        }
        return self
    }
    
    
}
