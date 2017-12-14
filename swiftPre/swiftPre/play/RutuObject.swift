//
//  RutuObject.swift
//  SwiftTest
//
//  Created by apple on 2016/12/20.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class RutuObject: NSObject {
    var ret:Int = 0
    var msg:String?
    var famous: [AnchorInfo]? //msg
    
    
    public func analyJsonRutu(dictory:Dictionary<String, Any>) -> RutuObject {
        self.ret = (dictory["ret"] as? Int)!
        self.msg = dictory["msg"] as? String
        
        let array:Array<AnyObject> = dictory["famous"] as! Array<AnyObject>
        
        var anchorArray = Array<AnchorInfo>()
        
        for  dic in array {
            let info  = AnchorInfo().anayAnchorInfo(dictory:dic as AnyObject)
            print(dic)
            anchorArray.append(info)
        }
        print(array)
        self.famous = anchorArray
        return self
    }
    
}
