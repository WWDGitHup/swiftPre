//
//  RadioData.swift
//  swiftPre
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit
import HandyJSON
class RadioData: HandyJSON {
    var con:Array<LiveListModel>?
    var totalPage:Int?
    var rt:Int?
    var perPage:Int?
    var currentPage:Int?
    var count:Int?
    required init(){}
}
