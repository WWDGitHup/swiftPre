//
//  SectionDetailsModel.swift
//  swiftPre
//
//  Created by apple on 2017/1/10.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit
import HandyJSON
class SectionDetailsModel: HandyJSON {

    var collectNumber:Int?
    var commentNumber:Int?
    var id:Int?
    var isCollect:Int?
    var resourceId:Int?
    var type:Int?
    var providerCode:Int?
    var lookNumber:Int?
    var cover:String?
    var createTime:String?
    var descriptions:String?
    var name:String?
    required init(){}
}
