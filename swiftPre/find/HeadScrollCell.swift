//
//  HeadScrollCell.swift
//  SwiftTest
//
//  Created by apple on 2016/12/22.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class HeadScrollCell: UICollectionViewCell {
    
    fileprivate var headScrollerView:UIScrollView = UIScrollView()
    fileprivate var dataSource:[BannerInfo]?
    
    fileprivate var currentIndex:Int = 0
    fileprivate var totalPage:Int = 0
    fileprivate var isBack:Bool = false
    fileprivate var isCanGo:Bool = false
    var scrollViewWidth:Int = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollViewWidth = Int(self.frame.size.width) - 20
        headScrollerView.frame = CGRect.init(x: 10, y: 5, width: scrollViewWidth, height: Int(self.frame.size.height))
        headScrollerView.showsVerticalScrollIndicator = false
        headScrollerView.showsHorizontalScrollIndicator = false
        headScrollerView.backgroundColor = UIColor.white
        headScrollerView.isPagingEnabled = true
        self.addSubview(headScrollerView)
        
        //定时滚动
        self.setTimer()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension HeadScrollCell{
    public func loadData(array:[BannerInfo]){
        
        for banner in array {
            let index:Int = array.index(of: banner)!
            
            let imageView = self.headScrollerView.viewWithTag(index + 1000)
            
            if imageView != nil {
                let image:UIImageView = imageView as! UIImageView
                if banner.url != nil {
                    image.sd_setImage(with: URL.init(string: banner.url!))
                    image.tag = 1000 + index
                    
                }
            }else{
                
                if banner.url != nil {
                    let originX = Int( index) * Int(scrollViewWidth)
                    let imageView:UIImageView = UIImageView.init(frame:CGRect.init(x:CGFloat(originX), y: 0, width: self.frame.size.width, height: self.frame.size.height))
                    imageView.sd_setImage(with: URL.init(string: banner.url!))
                    imageView.tag = 1000 + index
                    self.headScrollerView.addSubview(imageView)
                }
            }
        }
        let count:Int = array.count
        totalPage = array.count
        self.headScrollerView.contentSize = CGSize.init(width: CGFloat(count * Int(scrollViewWidth)), height: 0)
        
    }

}


extension HeadScrollCell{
    func setTimer() -> () {
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { (timer:Timer) -> () in
                
                if self.isCanGo{
                    self.setScrollViewOffsize()
                    self.isCanGo = false
                }else{
                    self.isCanGo = true
                }
                
            })
        } else {
            // Fallback on earlier versions
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.timeSchedul(timer:)), userInfo: nil, repeats: true)
        }
    
    }
    
    func timeSchedul(timer:Timer) -> () {
        self.setScrollViewOffsize()
    }
    
    func setScrollViewOffsize() -> () {
        if self.currentIndex > self.totalPage
        {
            self.currentIndex = 0
        }
        if self.isBack{
            //返回
            if self.currentIndex == 0
            {
                self.currentIndex += 1
                self.isBack = false
            }else{
                self.currentIndex -= 1
            }
            
        }else{
            //向右
            if self.currentIndex == self.totalPage - 1
            {
                
                self.currentIndex -= 1
                self.isBack = true
                
            }else{
                self.currentIndex += 1
            }
            
        }
        
        UIView.animate(withDuration: 0.25, animations: {() -> () in
            
            self.headScrollerView.contentOffset = CGPoint.init(x: CGFloat(self.currentIndex * self.scrollViewWidth), y: 0)
        })
    }
}


