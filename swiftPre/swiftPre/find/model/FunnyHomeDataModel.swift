//
//  FunnyHomeDataModel.swift
//  SwiftTest
//
//  Created by apple on 2016/12/27.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import HandyJSON
class FunnyHomeDataModel: HandyJSON {
    
    var has_more:Int?
    var min_time:Int?
    var max_time:Int?
    var tip:String?
    var data:[FunnyRecommendModel]?
    
    
    required init(){}

}
