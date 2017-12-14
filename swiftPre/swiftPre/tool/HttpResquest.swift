//
//  HttpResquest.swift
//  SwiftTest
//
//  Created by apple on 2016/12/19.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import AFNetworking

//let singleThree = HttpResquest()

class HttpResquest: AFHTTPSessionManager {

    //设置单例  第一种设置方法
//     static let sharedInstanced = HttpResquest()
    //单例第二种 设置方法
//    class var shardeInstanced :HttpResquest{
//        return singleThree
//    }
//    
    //第三种 方法
    static var sharedInstanced :HttpResquest{
        struct HttpStatic {
            static let instance:HttpResquest = HttpResquest()
            
        }
        HttpStatic.instance.responseSerializer.acceptableContentTypes =  NSSet(objects:"application/json","text/json","text/javascript","text/plain","text/html") as? Set<String>
        HttpStatic.instance.requestSerializer = AFHTTPRequestSerializer.init()
        HttpStatic.instance.requestSerializer.setValue(nil, forHTTPHeaderField: "Content-Type")
        return HttpStatic.instance
    }
    
    
}
