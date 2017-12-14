//
//  StringTool.swift
//  SwiftTest
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 weidong. All rights reserved.
//

import Foundation
import UIKit

extension String{
    public func getStringHeight(font:UIFont,limitWidth:CGFloat) -> CGFloat{
        
        let dictory:Dictionary = [NSFontAttributeName:font]
        let size:CGSize = CGSize.init(width: limitWidth, height:CGFloat(MAXFLOAT))
        
        let rect:CGRect = self.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dictory, context: nil)
        
        return rect.size.height
    }
    
   public func getSecondUserTime(time:String?) -> Int {
        guard time != nil else {
            return 0
        }
        let array = time?.components(separatedBy: ":")
        guard (array?.count)! == 2 || (array?.count)! > 2 else {
            return 0
        }
        let hour = array?[0]
        let min = array?[1]
        if hour != nil && min != nil{
            let second = Int(hour!)! * 60 + Int(min!)!
            return second
        }
        return 0
    }
    
   public func getNowSecond() -> Int {
        let date = Date()
        let timeFm = DateFormatter()
        timeFm.dateFormat = "HH:mm"
        let strTime = timeFm.string(from: date)
        return self.getSecondUserTime(time: strTime)
    }
    

}



extension NSObject{
    
    public func widthForUI(margin:Int,marginCount:Int,count:Int) -> CGFloat{
        
        let WidthAll = UIScreen.main.bounds.width  - CGFloat(marginCount * margin)
        let widthO = Int(WidthAll) / count
        // 有问题 暂时设定 后期修改
        if UIScreen.main.bounds.width > 414 {
            let WidthAllT = 375 - CGFloat(marginCount * margin)
            let width = Int(WidthAllT) / count
            return CGFloat(width + margin * 2)
        }
        return CGFloat(widthO + margin * 2)
        
    }
    
    

    
}


