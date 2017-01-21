//
//  AVPlayerModel.swift
//  SwiftTest
//
//  Created by apple on 2017/1/2.
//  Copyright © 2017年 weidong. All rights reserved.
//

import UIKit

class AVPlayerModel: NSObject {

    static let sharedInstanced:AVPlayerModel = AVPlayerModel()
    
    public var currentPlayUrlString:String?

}
