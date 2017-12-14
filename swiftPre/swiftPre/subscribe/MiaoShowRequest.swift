//
//  MiaoShowRequest.swift
//  swiftPre
//
//  Created by apple on 2017/1/23.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit
import HandyJSON
//MARK: 设置代理数据回调
protocol MiaoShowRequestDelegate:class{
    func getMiaoShowHotListReturnBack(pageIndex:Int,list:LiveListInfo)
    func getMiaoShowHotListReturnBackFaild(error:Error)
}

class MiaoShowRequest: NSObject {
    
    let MiaoShowRequestHotList = "MiaoShowRequestHotList"
    let MiaoShowRequestHotDetail = "MiaoShowRequestHotDetail"
    let MiaoShowRequestHotBigpic = "MiaoShowRequestHotBigpic"
    weak var delegate:MiaoShowRequestDelegate?
    
    func getMiaoShowHotList(pageIndex:Int) {
        
        let urlString:String = "https://live.9158.com/Fans/GetHotLive?page=\(pageIndex)"
        HttpResquest.sharedInstanced.get(urlString, parameters: nil, progress: { (progress:Progress) in
            
        }, success: { (task:URLSessionDataTask, responseObject:Any?) in
            if responseObject != nil{
                let dictory:Dictionary<String,AnyObject> = responseObject as! Dictionary<String,AnyObject>
                let listDic:Dictionary<String,AnyObject> = dictory["data"] as! Dictionary<String, AnyObject>
                let liveListInfo:LiveListInfo =  JSONDeserializer<LiveListInfo>.deserializeFrom(dict: listDic as NSDictionary?)!
                print(liveListInfo)
                
                self.delegate?.getMiaoShowHotListReturnBack(pageIndex: pageIndex, list: liveListInfo)
            }
            
        }, failure: { (task:URLSessionDataTask?, error:Error) in
            self.delegate?.getMiaoShowHotListReturnBackFaild(error: error)
        })
    }
    func reformData(originData:Dictionary<String,AnyObject>,manager:AnyObject) -> Dictionary<String,AnyObject> {
        
        if manager.isKind(of: SubscribeViewController.self) {
            
            return originData
        }
        
        if originData[MiaoShowRequestHotDetail] != nil {
            
            return [MiaoShowRequestHotBigpic:originData["bigpic"]!]
        }
        return originData
    }
    
    
    
    
}
