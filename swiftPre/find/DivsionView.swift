//
//  DivsionView.swift
//  SwiftTest
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class DivsionView: UIView ,UIScrollViewDelegate{
    
    var headView:UIView = UIView() //头部分割view 两个
    
    var contectScrollView:UIScrollView = UIScrollView()
    
    var lastIndex:Int = 0
    
    
    init(frame: CGRect,titileArray:Array<String>,contectView:Array<UIView>) {
        super.init(frame: frame)
        
        headView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 35)
        for title in titileArray
        {
            let index = titileArray.index(of: title)
            let originX = index! * (Int(self.frame.size.width) / Int(titileArray.count))
            let button:UIButton = UIButton.init(frame: CGRect.init(x: originX, y: 0, width: (Int(self.frame.size.width) / Int(titileArray.count)), height: Int(self.frame.size.height)))
            button.setTitle(title, for: UIControlState.normal)
            button.setTitle(title, for: UIControlState.selected)
            button.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            button.setTitleColor(UIColor.init(colorLiteralRed: 49 / 255.0, green: 155/255.0, blue: 1.0, alpha: 1.0), for: UIControlState.selected)
            button.addTarget(self, action: #selector(self.buttonClick(button:)), for: UIControlEvents.touchUpInside)
            button.tag = index! + 3000
            self.addSubview(button)
            if index! == 0 {
                button.isEnabled = true
            }
        }
        self.addSubview(headView)
        
        
        contectScrollView.frame = CGRect.init(x: 0, y: headView.frame.size.height, width: self.frame.size.width, height: self.frame.size.height - headView.frame.size.height)
        contectScrollView.showsVerticalScrollIndicator = false
        contectScrollView.showsHorizontalScrollIndicator = false
        contectScrollView.backgroundColor = UIColor.white
        contectScrollView.isPagingEnabled = true
        contectScrollView.delegate = self
        contectScrollView.backgroundColor = UIColor.yellow
        self.addSubview(contectScrollView)
        
        
        for view  in contectView {
            let index = contectView.index(of: view)
            view.frame = CGRect.init(x:CGFloat(index!) * self.frame.size.width, y: 0, width: contectScrollView.frame.size.width, height: contectScrollView.frame.size.height)
            contectScrollView.addSubview(view)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonClick(button:UIButton){
        
        let object = headView.viewWithTag(lastIndex)
        if object != nil {
            if (object?.isKind(of: UIButton.self))! {
                let button:UIButton = object as! UIButton
                button.isSelected = false
            }
        }
        lastIndex = button.tag - 3000
        if button.isSelected {
            return
        }
        
        button.isSelected = true
        print(button.tag)
        
        self.contectScrollView.contentOffset = CGPoint.init(x: lastIndex * Int(self.frame.size.width), y: 0)
        
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //取出将要显示的界面
        let index:Int = Int(contectScrollView.contentOffset.x) / Int(contectScrollView.frame.size.width)
        //设置所有的button为未选中
        for view in headView.subviews{
            if view .isKind(of: UIButton.self) {
                let button:UIButton = view as! UIButton
                button.isSelected = false
            }
        }
        
        let object = headView.viewWithTag(index + 3000)
        if object != nil {
            let button:UIButton = object as! UIButton
            button.isSelected = true
        }
        
        
    }
    
    
}
