//
//  VTScrollFlowLayout.swift
//  swiftPre
//
//  Created by apple on 2017/1/6.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit

class VTScrollFlowLayout: UICollectionViewFlowLayout {
    
    let imageHeight = 90
    let imageWidth = 110

    override init() {
        super.init()
        
        self.itemSize = CGSize.init(width: imageWidth, height: imageHeight)
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = self.itemSize.width * 0.5  //每个item的间距
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //自动重载
    override func prepare() {
        super.prepare()
        //设置边距 让第一张图与最后一张图显示在正中央
        let inset = (self.collectionView?.bounds.width ?? 0)  * 0.5 - self.itemSize.width * 0.5
        self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset)
        
        print("prepare  --- 加载")
    }
    
    //OC
    //自定义layout 必须重载三个方法  1：返回可见区域尺寸 2；返回可见区域尺寸内item数组（UICollectionViewLayoutAttributes） 3：当滚动时一直重载 collectionview
    //在swift 中实现可视区域尺寸 变成只读属性  不需要再设置
    //    override var collectionViewContentSize: CGSize
    
    //返回可见区域尺寸内item数组
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //获取rect 范围内所有UICollectionViewLayoutAttributes
        let layoutArray = super.layoutAttributesForElements(in: rect)
        //找出可视范围
        let visibleRect = CGRect.init(x: (self.collectionView?.contentOffset.x)!, y: 0, width: (self.collectionView?.frame.size.width)!, height: (self.collectionView?.frame.size.height)!)
        
        //在可视范围内做动画
        
        //获取collectionviewCenterX 中央位置
        let centerX = (self.collectionView?.contentOffset.x)! + (self.collectionView?.frame.size.width)! / 2
        let maxCenterMargin = (self.collectionView?.bounds.width)! / 2 + CGFloat(imageWidth / 2) //作为参数计算放大倍数
        
        
        for attributes in layoutArray! {
            if !visibleRect.intersects(attributes.frame) {
                continue
            }
            //放大缩小倍数 abs（）： 取绝对值
            let scale = 1 + (0.8 - abs(centerX - attributes.center.x) / maxCenterMargin)
            attributes.transform = CGAffineTransform.init(scaleX: scale, y: scale)
        }
        return layoutArray
    }
    
    //返回true 只要显示的边界发生改变就重新布局  内部会重新调用prepare和调用
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    /**
     用来设置collectionView停止滚动那一刻的位置
     
     - parameter proposedContentOffset: 原本collectionView停止滚动那一刻的位置
     - parameter velocity:              滚动速度
     
     - returns: 最终停留的位置
     */
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let lastRect = CGRect.init(x: proposedContentOffset.x, y: proposedContentOffset.y, width: (self.collectionView?.bounds.width)!, height: (self.collectionView?.bounds.height)!)
        //获取要停留的中央位置
        let centerX = proposedContentOffset.x + (self.collectionView?.frame.size.width)! * 0.5
        
        //获取所有item  UICollectionViewLayoutAttributes 数组
        let array = self.layoutAttributesForElements(in: lastRect)
        //需要移动的位置
        var adjustOffsizeX = CGFloat(MAXFLOAT)
        for attribute in array! {
            
            if abs(attribute.center.x - centerX) < abs(adjustOffsizeX)  {
                adjustOffsizeX = attribute.center.x - centerX;
            }
            
        }
        return CGPoint(x: proposedContentOffset.x + adjustOffsizeX, y: proposedContentOffset.y)
    }

    
}
