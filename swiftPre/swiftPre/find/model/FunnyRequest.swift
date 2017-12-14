//
//  FunnyRequest.swift
//  SwiftTest
//
//  Created by apple on 2016/12/27.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import HandyJSON
import AFNetworking
class FunnyRequest: NSObject {
    
    //设置回调
    typealias FunnyVideoRequestBack = (_ dataModel:FunnyHomeDataModel?,_ succeed:Bool,_ error:Error?) -> ()
    
    func requestFunnyVideoList(funnyBack: @escaping FunnyVideoRequestBack){
        let dats:Date = Date()
        let sec:Int = Int(dats.timeIntervalSince1970)
        var secStr =  String(sec)
        secStr = secStr.appending(".24")
        
        let parameter:Dictionary<String,String> = ["tag":"joke","iid":"5316804410","os_version":"10.2","os_api":"18","app_name":"joke_essay","channel":"App Store","device_platform":"iphone","idfa":"832E262C-31D7-488A-8856-69600FAABE36","live_sdk_version":"120","vid":"4A4CBB9E-ADC3-426B-B562-9FC8173FDA52","openudid":"cbb1d9e8770b26c39fac806b79bf263a50da6666","device_type":"iPhone 6 Plus","version_code":"5.5.0","ac":"WIFI","screen_width":"1242","device_id":"10752255605","aid":"7","count":"50","max_time":secStr]
        let tool = HttpResquest.sharedInstanced
        tool.get("http://lf.snssdk.com/neihan/stream/mix/v1/?content_type=-104", parameters: parameter, progress: { (progress:Progress?) in
            
        }, success: { (dataTask:URLSessionDataTask?, responseData:Any?) in
            
            if responseData != nil {
                let dictory:Dictionary<String,AnyObject> = responseData as! Dictionary<String,AnyObject>
                let jsonDic =  dictory["data"]
                if jsonDic != nil{
                    print(jsonDic!)
                    let dictoryJson:Dictionary<String,AnyObject> = jsonDic as! Dictionary<String,AnyObject>
                    let funnyHome = JSONDeserializer<FunnyHomeDataModel>.deserializeFrom(dict: dictoryJson as NSDictionary?)
                    if funnyHome != nil {
                        funnyBack(funnyHome,true,nil)
                    }
                }
            }
        }) { (dataTask:URLSessionDataTask?, error:Error) in
            funnyBack(nil,true,error)
        }
    }

}
