//
//  PageContentView.swift
//  SwiftTest
//
//  Created by apple on 2016/12/21.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

//MARK:  设置代理
protocol PageContentViewDelegate :NSObjectProtocol{
    func pageContentView(_ contentView:PageContentView, sourceIndex:Int ,toIndex:Int ,progress:CGFloat)
}
//设置代理 滚动到那个试图
protocol ScrollEndIndexDelegate:NSObjectProtocol{
    func scrollToIndex(toIndex:Int ,fromIndex:Int)
}

class PageContentView: UIView,UIScrollViewDelegate {
    
    var sourceIndex:Int = 0
    
    public var viewControllerArray:[UIViewController]? = Array()
    public var selectedIndex :Int = 0
    
    fileprivate var scrollView:UIScrollView = UIScrollView()
    
    //设置代理 使用weak修饰 防止循环引用
    public weak  var delegate:PageContentViewDelegate?
    public weak var endScrollDelegate:ScrollEndIndexDelegate?
    
    init(frame: CGRect , vcArray:[UIViewController],index:Int) {
        viewControllerArray = vcArray
        selectedIndex = index
        
        super.init(frame:frame)
        //创建试图
        self.setContentUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// 创建UI
extension PageContentView{
    fileprivate func setContentUI() -> (){
        scrollView.frame = CGRect.init(x: 0, y: 0, width: bounds.width, height: bounds.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        self.addSubview(scrollView)
        
        
        
        for viewController in self.viewControllerArray! {
            let vcIndex:Int = (self.viewControllerArray?.index(of: viewController))!
            var originX:Float = 0.0
            originX = Float(vcIndex) * Float(bounds.width)
            viewController.view.frame = CGRect.init(x:CGFloat(originX), y:0 , width:bounds.width, height:bounds.height)
            scrollView.addSubview(viewController.view)
            
            print(viewController.view.frame.size.height)
        }
        
        scrollView.contentSize = CGSize.init(width:CGFloat(Float(bounds.width) * Float(self.viewControllerArray!.count)), height: 0)
    }
}



//MARK: scrollview delegate
extension PageContentView{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var progress:CGFloat = 0
        var toIndex:Int = 0
        progress = scrollView.contentOffset.x - CGFloat(CGFloat(sourceIndex) * scrollView.frame.size.width)
        
        toIndex = Int(CGFloat((scrollView.contentOffset.x + scrollView.contentSize.width) / scrollView.contentSize.width))
        
        if toIndex > sourceIndex {
            //向右滚动
            toIndex = sourceIndex + 1
            if toIndex + 1 > (self.viewControllerArray?.count)! {
                toIndex = (self.viewControllerArray?.count)!
            }
        }else{
            toIndex = sourceIndex - 1
            if toIndex < 0 {
                toIndex = 0
            }
        }
        
        delegate?.pageContentView(self, sourceIndex: sourceIndex, toIndex: toIndex, progress: progress)
        
        print("progress = \(progress)   sourceIndex = \(sourceIndex)     toIndex = \(toIndex)")
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let toIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.size.width)
        endScrollDelegate?.scrollToIndex(toIndex: toIndex, fromIndex: sourceIndex)
        sourceIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.size.width)
        print("滑动结束了")
        //结束 代理回调
    }
    
}


extension PageContentView{
    
    public func setScrollViewContentOffSet(index:Int) -> (){
   
        UIView.animate(withDuration: 0.25, animations: {() -> () in
            self.scrollView.contentOffset = CGPoint.init(x: CGFloat(index * Int(self.frame.size.width)), y: 0)
            });
        
    }
    
}







