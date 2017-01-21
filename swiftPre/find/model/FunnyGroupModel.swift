//
//  FunnyGroupModel.swift
//  SwiftTest
//
//  Created by apple on 2016/12/27.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import HandyJSON
class FunnyGroupModel: HandyJSON {

    var text:String?
    var share_url:String?
    var category_name:String?
    var status_desc:String?
    var content:String?
    var m3u8_url:String?
    var cover_image_url:String?
    var mp4_url:String?
    
    
    
    var category_id:Int?
    var create_time:Int?
    var id:Int?
    var favorite_count:Int?
    var user_favorite:Int?
    var share_type:Int?
    var is_can_share:Int?
    var category_type:Int?
    var go_detail_count:Int?
    var comment_count:Int?
    var label:Int?
    var share_count:Int?
    var id_str:Int?
    var media_type:Int? // 1 大图 2Gif 3 视频 4 小图 5精华
    var type:Int?
    var status:Int?
    var thas_commentsype:Int?
    var user_bury:Int?
    var user_digg:Int?
    var bury_count:Int?
    var online_time:Int?
    var repin_count:Int?
    var digg_count:Int?
    var has_hot_comments:Int?
    var user_repin:Int?
    var duration:Int?
    var allow_dislike:Int?
    var category_visible:Int?
    var is_anonymous:Int?
    var is_multi_image:Int?
    var is_gif:Int?
    var has_comments:Int?
    var video_height:Int?
    var video_width:Int?
    
    var video_360P:FunnyVideoThree?
    var video_720P:FunnyVideoThree?
    var video_480p:FunnyVideoThree?
    var large_cover:FunnyVideoThree?
    var medium_cover:FunnyVideoThree?
    var origin_video:FunnyVideoThree?
    var gifvideo:FunnyGifVideo?
    
    var user:FunnyUserInfo?
    var large_image:FunnyLargeImage?
    var middle_image:FunnyLargeImage?
    
    var dislike_reason:[FunnyDislikeReason]?
    var large_image_list:[FunnyVideoThree]?
    var thumb_image_list:[FunnyVideoThree]?
    

    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &video_360P, name: "360p_video")
        mapper.specify(property: &video_720P, name: "720p_video")
        mapper.specify(property: &video_480p, name: "480p_video")
        
    }
    
    required init(){
        
    }
    
}


