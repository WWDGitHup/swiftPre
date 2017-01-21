//
//  FunnyRecommendModel.swift
//  SwiftTest
//
//  Created by apple on 2016/12/27.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import HandyJSON

class FunnyRecommendModel:HandyJSON  {

    var comments:[CommentModel]?
    var group:FunnyGroupModel?
    var type:Int?
    var display_time:Int?
    var online_time:Int?
    
    required init(){}
    
    
}
