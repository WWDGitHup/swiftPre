//
//  CommentModel.swift
//  SwiftTest
//
//  Created by apple on 2016/12/27.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import HandyJSON

class CommentModel: HandyJSON {

    var text:String?
    var share_url:String?
    var user_name:String?
    var user_profile_image_url:String?
    var platform:String?
    var platformid:String?
    var user_profile_url:String?
    var avatar_url:String?
    
    var user_verified:Int?
    var create_time:Int?
    var user_bury:Int?
    var user_id:Int?
    var is_digg:Int?
    var id:Int?
    var status:Int?
    var share_type:Int?
    var group_id:Int?
    var comment_id:Int?
    var reply_comments:[CommentModel]?
    
    required init(){}
    
}
