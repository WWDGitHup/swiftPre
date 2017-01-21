//
//  RecommendInfo.swift
//  SwiftTest
//
//  Created by apple on 2016/12/22.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class RecommendInfo: NSObject {
    var bannerList:[AnyObject]?
    var con:[AnyObject]?
    var des:String?
    
    public func analyzeRecommendInfo(dictory:Dictionary<String,AnyObject>) -> RecommendInfo{
        self.des = dictory["des"] as? String
        let conArray:[AnyObject] = dictory["con"] as! Array<AnyObject>
        var proArray:[ProgramList] = Array()
        
        for object in conArray {
            let obj = object as! Dictionary<String,AnyObject>
            let progarm:ProgramList = ProgramList().analyzeProgramList(dictory: obj)
            proArray.append(progarm)
        }
        self.con = proArray
        
        
        let banner:[AnyObject] = (dictory["bannerList"] as? Array)!
        var bannerArray:[BannerInfo] = Array()
        
        for banner in banner {
            let obj = banner as! Dictionary<String,AnyObject>
            let progarm:BannerInfo = BannerInfo().analyzeBannerInfo(dictory: obj)
            bannerArray.append(progarm)
        }
        self.bannerList = bannerArray
        
        
        return self
    }
    
}
