//
//  RadioInfoModel.swift
//  swiftPre
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit
import HandyJSON
class RadioInfoModel: HandyJSON {
    
    var anchorerson:String?
    var clicks:Int?
    var cover:String?
    var detailIntroduce:String?
    var id:Int?
    var introduce:String?
    
    var logoUrl:String?
    var name:String?
    var playUrl:String?
    var title:String?
    
    var remark:String?
    var radioId:Int?
    
    var modelType:Int?
    
    var con:Array<AnchorpersonModel>?
    
    required init(){}

}
