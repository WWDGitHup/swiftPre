//
//  PageControlView.swift
//  SwiftTest
//
//  Created by apple on 2016/12/21.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

protocol PageControllDelegate:class {
    func scrollToObjectivePosition(toIndex:Int, fromIndex:Int)
}

class PageControlView: UIView ,UIScrollViewDelegate{

    var titles:[String]? // 控制器名称
    
    var index = 0   // 当前选中的index
    
    fileprivate  var scrollView:UIScrollView = UIScrollView()
    weak var delegate:PageControllDelegate?
    
    var lineLabel:UILabel = UILabel()
    var labelW:CGFloat = 0
    
    
    //MARK:  初始化
    
    init(frame: CGRect , currentIndex:Int,titles:[String]) {
        
        self.titles = titles
        self.index = currentIndex
        super.init(frame: frame)
        //创建UI
        self.setupUI()

    }
    
    func setupUI() -> () {
        scrollView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 49)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = false
        scrollView.scrollsToTop = false
        scrollView.backgroundColor = UIColor.init(red: 242 / 255.0, green: 242 / 255.0, blue: 242 / 255.0, alpha: 1.0)
        self.addSubview(scrollView)
        
        //加载
        var count:Int  = 5
        if (self.titles?.count)! > 0 {
            count = (self.titles?.count)!
        }
        
        
        var labelWidth:Float = Float(self.frame.size.width) / Float(5.0)
        if count > 5 {
            labelWidth = Float (self.frame.size.width) / Float(5.0)
        }else{
            if (self.titles?.count)! > 0 {
                labelWidth = Float (self.frame.size.width) / Float(count)
            }else{
                labelWidth = Float (self.frame.size.width)
            }
        }
        if labelWidth > 85 {
            labelWidth = 75
        }
        labelW = CGFloat(labelWidth)
        if (self.titles?.count)! > 0 {
            for i in 0 ... (self.titles?.count)!-1{
                let originX = i * Int(labelWidth)
                let title = self.titles?[i]
                let button:UIButton = UIButton.init(frame: CGRect.init(x: Double(originX), y: 0, width: Double(labelWidth), height:44))
                button.setTitle(title, for: UIControlState.normal)
                button.titleLabel?.textAlignment = NSTextAlignment.center
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                button.tag = i + 30000;
                button.addTarget(self, action:#selector(buttonClick(button:)), for: UIControlEvents.touchUpInside)
                button.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
                button.setTitleColor(UIColor.red, for: UIControlState.selected)
                scrollView.addSubview(button)
            }
        }
        scrollView.contentSize = CGSize.init(width:CGFloat(Float(labelWidth) * Float(count)), height: 0)
        print("self.frame.size.height  == \(self.frame.size.height)     \(self.scrollView.contentSize )")
        
        let originX = index * Int(labelWidth)
        lineLabel.frame = CGRect.init(x: CGFloat(originX + (Int(labelWidth) - 40) / 2)  , y: 40, width: 40, height: 2)
        lineLabel.backgroundColor = UIColor.red
        scrollView.addSubview(lineLabel)
    }
    
    
    func buttonClick(button:UIButton) -> () {
        print("点击了 \(button.tag)")
        
        delegate?.scrollToObjectivePosition(toIndex: button.tag - 30000 ,fromIndex: self.index)
        
        index = button.tag - 30000
        let originX = (button.tag - 30000) * Int(labelW)
        UIView.animate(withDuration: 0.25, animations: {() -> Void in
            self.lineLabel.frame =  CGRect.init(x: CGFloat(originX + (Int(self.labelW) - 40) / 2)  , y: 40, width: 40, height: 2)
        })
        
        print("点击了 \(originX)")

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PageControlView{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
    }
}

extension PageControlView{
    public func setLineFrame(progress:CGFloat ,fromIndex:Int ,toIndex:Int) ->(){
        //progress 表示较上一次的偏移量
        let rate:Float = Float(progress) / Float(self.frame.width)
        let positionX = Float(fromIndex) * Float(labelW) + Float(labelW - 40) / 2
        let originX:Float =  positionX + Float(rate) * Float(labelW)
        self.lineLabel.frame = CGRect.init(x: CGFloat(originX)  , y: 40, width: self.lineLabel.frame.width, height: self.lineLabel.frame.height)
        
        print( "originX  ---    \(rate)")
    }
}



