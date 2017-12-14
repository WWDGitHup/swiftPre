//
//  FindRequest.swift
//  SwiftTest
//
//  Created by apple on 2016/12/22.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import HandyJSON

class FindRequest: NSObject {
    
    //设置成单例
    static let sharedInstanced:FindRequest = FindRequest()
    //MARK:  获取推荐界面的数据
    //设置闭包回调
    typealias findDataReturn = (_ info:RecommendInfo?,Bool,_ error:Error?) -> ()
    typealias ablumSongInfoReturn = ( _ info:AlbumInfo?,_ succeed:Bool,_ error:Error?) -> ()
    typealias moreAlbumRe = (_ albumList:MoreAlbumList?,_ succeed:Bool,_ error:Error?) ->()
    typealias liveDataReturn = (RadioData?,Bool,Error?) ->()
    typealias liveDetailReturn = (RadioDetailData?,Bool,Error?) ->()
    
    var findLoadDataFinished:findDataReturn?
    var albumSongDataFinshed:ablumSongInfoReturn?
   
    
    
    func loadRecommendData(mobile:String?) -> () {
  
        weak var weakSelf:FindRequest? = nil
        weakSelf = self
        let parameters:Dictionary<String,String>?
        if mobile != nil {
            parameters = ["mobileId":mobile!]
        }else{
            parameters = nil
        }
        
        let object:HttpResquest = HttpResquest.sharedInstanced
        object.post("https://xlapp.linker.cc/xllhsrv/srv/interactive/index", parameters: parameters, progress:{(progress:Progress) -> Void in
        }, success: {(dataTask:URLSessionDataTask, responseObject:Any?) -> Void in
            if responseObject != nil{
                let obj:Dictionary<String,AnyObject> = responseObject as! Dictionary<String,AnyObject>
                let recommend:RecommendInfo = RecommendInfo().analyzeRecommendInfo(dictory: obj)
                if weakSelf?.findLoadDataFinished != nil
                {
                    weakSelf?.findLoadDataFinished!(recommend,true,nil)
                }
            }

        }, failure: {(dataTask:URLSessionDataTask?, error:Error) -> Void in
        
            if weakSelf?.findLoadDataFinished != nil
            {
                weakSelf?.findLoadDataFinished!(nil,false,error)
            }
        })
    }
    
    
    func loadAlbumList(pageIndex:String,pid:String,providerCode:String) {
        
        weak var weakSelf:FindRequest? = nil
        weakSelf = self
        let parameters:Dictionary<String,String> = ["pageIndex":pageIndex,"pid":pid,"providerCode":providerCode]
        let object:HttpResquest = HttpResquest.sharedInstanced
        object.post("https://xlapp.linker.cc/xllhsrv/srv/wifimusicbox/demand/detail", parameters: parameters, progress:{(progress:Progress) -> Void in
        }, success: {(dataTask:URLSessionDataTask, responseObject:Any?) -> Void in
            if responseObject != nil{
                let dictory:Dictionary<String,AnyObject> = responseObject as! Dictionary<String,AnyObject>
                let albumInfo:AlbumInfo = AlbumInfo().analyzeAlbumInfo(dictory: dictory)

                if weakSelf?.albumSongDataFinshed != nil{
                    weakSelf?.albumSongDataFinshed!(albumInfo,true,nil)
                }
            }
            
        }, failure: {(dataTask:URLSessionDataTask?, error:Error) -> Void in
            if weakSelf?.albumSongDataFinshed != nil{
                weakSelf?.albumSongDataFinshed!(nil,false,error)
            }
        })
    }
    
    //MARK: 更多界面数据加载
    func MoreAlbumLoad(pageIndex:String,atypeId:String,moreAlbum:@escaping moreAlbumRe){
        let urlStr:String = "https://xlapp.linker.cc/xllhsrv/srv/classification/channelAlbumDetail/list/".appending(atypeId).appending("/\(pageIndex)")
        HttpResquest.sharedInstanced.get(urlStr, parameters: nil, progress: { (progress:Progress) in
            
        }, success: { (task:URLSessionDataTask, responseObject:Any?) in
            
            if responseObject != nil {
                let dictory:Dictionary<String,AnyObject> = responseObject as! Dictionary<String,AnyObject>
                let responds:MoreAlbumList = MoreAlbumList().analyzeMoreAlbumList(dictory: dictory)
                moreAlbum(responds,true,nil)
                
            }

        }) { (dataTask:URLSessionDataTask?, error:Error) in
            moreAlbum(nil,false,error)
        }
    }
    
    
    func radioStattionDataLoad(radio:@escaping liveDataReturn) {
        
        HttpResquest.sharedInstanced.get("https://xlapp.linker.cc/xllhsrv/srv/radio/live_radiostudio/list/0", parameters: nil, progress: { (progress:Progress) in
            
        }, success: { (dataTask:URLSessionDataTask, responseData:Any?) in
            if responseData != nil{
                let dictory:Dictionary<String,AnyObject> = responseData as! Dictionary<String,AnyObject>
                let radioData:RadioData = JSONDeserializer.deserializeFrom(dict: dictory as NSDictionary?)!
                radio(radioData,true,nil)
            }
            
        }) { (dataTask:URLSessionDataTask?, error:Error) in
            radio(nil,false,error)
        }
        
    }
    
    func radioProgramDetailDataLoad(userId:String,detail: @escaping liveDetailReturn) {
        
        let parameters:Dictionary<String,String> = ["userId":userId,"mobileId":"92EF5988-B132-4F20-9D0D-BB4EF68F274E"]
        let object:HttpResquest = HttpResquest.sharedInstanced
        object.post("https://xlapp.linker.cc/xllhsrv/srv/djStudio/details", parameters: parameters, progress:{(progress:Progress) -> Void in
        }, success: {(dataTask:URLSessionDataTask, responseObject:Any?) -> Void in
            if responseObject != nil{
                let dictory:Dictionary<String,AnyObject> = responseObject as! Dictionary<String,AnyObject>
                let radioData:RadioDetailData = JSONDeserializer.deserializeFrom(dict: dictory as NSDictionary?)!
                detail(radioData,true,nil)
                
            }
        }, failure: {(dataTask:URLSessionDataTask?, error:Error) -> Void in

            detail(nil,false,error)
        })
    }
}
