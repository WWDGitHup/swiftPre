//
//  ProgramList.swift
//  SwiftTest
//
//  Created by apple on 2016/12/22.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class ProgramList: NSObject {

    var categoryId:Int = 0
    var objectId:Int = 0
    var layout:Int = 0
    var name:String?
    var type:Int = 0
    var detailList:[DetailList] = Array()
    
    public func analyzeProgramList(dictory:Dictionary<String,AnyObject>) -> ProgramList {
        
        print(dictory)
        
        let objectiveAtate = dictory["name"]
        if  let sti = objectiveAtate {
            print(sti)
            self.name = sti as? String
        }
        
        let objId = dictory["id"]
        if  let oId = objId {
            print(oId)
            objectId = oId as! Int
        }
        
        if let layo = dictory["layout"] {
            self.layout = layo as! Int
        }
        
        if let ty = dictory["type"] {
            self.type = ty as! Int
        }
        
        
        let cate = dictory["categoryId"]
        if (cate?.isKind(of: NSNull.self))!  {
            
        }else{
            self.categoryId = cate as! Int
        }
        
        
        if dictory["detailList"] != nil {
            let detail:[AnyObject] = (dictory["detailList"] as? Array)!
            var detailArray:[DetailList] = Array()
            
            for object in detail {
                let obj = object as! Dictionary<String,AnyObject>
                let detail:DetailList = DetailList().anylyzeDetailInfo(dictory: obj)
                detailArray.append(detail)
            }
            self.detailList = detailArray
        }
        
        

        
        return self
    }
    
    
}
