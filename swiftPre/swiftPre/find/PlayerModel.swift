//
//  PlayerModel.swift
//  SwiftTest
//
//  Created by apple on 2017/1/3.
//  Copyright © 2017年 weidong. All rights reserved.
//

import UIKit

class PlayerModel: NSObject {

    var currentIndex:Int?
    var currentPlayerUrl:String?
    static let sharedInstanced:PlayerModel = PlayerModel()
    
    
}
