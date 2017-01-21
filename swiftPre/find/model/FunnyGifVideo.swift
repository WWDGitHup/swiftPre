//
//  FunnyGifVideo.swift
//  SwiftTest
//
//  Created by apple on 2016/12/27.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import HandyJSON
class FunnyGifVideo: HandyJSON {

    var mp4_url:String?
    var cover_image_uri:String?
    var video_height:Int?
    var video_width:Int?
    var duration:Float?
    var video_360P:FunnyVideoThree?
    var video_720P:FunnyVideoThree?
    var video_480P:FunnyVideoThree?
    
     required init (){}
}
