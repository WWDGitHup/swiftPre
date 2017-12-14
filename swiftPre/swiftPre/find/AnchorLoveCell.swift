//
//  AnchorLoveCell.swift
//  SwiftTest
//
//  Created by apple on 2016/12/22.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class AnchorLoveCell: UICollectionViewCell {
    
    fileprivate var scrollerView:UIScrollView = UIScrollView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollerView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        scrollerView.showsVerticalScrollIndicator = false
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.backgroundColor = UIColor.white
        scrollerView.bounces = false
        self.addSubview(scrollerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension AnchorLoveCell{
    public  func loadData(info:ProgramList?) -> () {
        if (info != nil) && info?.detailList != nil {
            
            for detail in (info?.detailList)! {
                
                let index:Int = (info?.detailList)!.index(of: detail)!
                
                let button = self.scrollerView.viewWithTag(index + 100)
                
                if button != nil {
                    let btn :UIButton = button as! UIButton
                    if detail.logo != nil {
                        btn.tag = 100 + index
                        btn.addTarget(self, action: #selector(self.buttonClick(btn:)), for: UIControlEvents.touchUpInside)
                        btn.sd_setImage(with: URL.init(string: detail.logo!), for: UIControlState.normal, completed: nil)
                        btn.layer.cornerRadius = 40
                        btn.clipsToBounds = true
                    }
                    
                }else{
                    
                    let margin:Int = Int(ScreenWidth - 80 * 3) / 4
                    if detail.logo != nil {
                        let btn:UIButton = UIButton.init(frame:CGRect.init(x:CGFloat(margin * (index + 1) + 80 * index), y: 20, width: 80, height: 80))
                        
                        btn.addTarget(self, action: #selector(self.buttonClick(btn:)), for: UIControlEvents.touchUpInside)
                        btn.sd_setImage(with: URL.init(string: detail.logo!), for: UIControlState.normal, completed: nil)
                        btn.tag = 100 + index
                        btn.layer.cornerRadius = 40
                        btn.clipsToBounds = true
                        self.scrollerView.addSubview(btn)
                    }
                }
                
                let label = self.scrollerView.viewWithTag(index + 200)
                if label != nil {
                    let leb :UILabel = label as! UILabel
                    if detail.name != nil {
                        leb.tag = 200 + index
                        leb.text = detail.name
                    }
                    
                }else{
                    
                    let margin:Int = Int(ScreenWidth - 80 * 3) / 4
                    if detail.name != nil {
                        let leb:UILabel = UILabel.init(frame:CGRect.init(x:CGFloat(margin * (index + 1) + 80 * index), y: 100, width: 80, height: 20))
                        leb.textAlignment = NSTextAlignment.center
                        leb.numberOfLines = 2
                        leb.tag = 200 + index
                        leb.text = detail.name
                        leb.font = UIFont .systemFont(ofSize: 13)
                        leb.textColor = UIColor.darkGray
                        self.scrollerView.addSubview(leb)
                    }
                }
                
            }
            let margin:Int = Int(ScreenWidth - 80 * 3) / 4
            let width = (80 + margin) * Int( (info?.detailList.count)!) + margin
            self.scrollerView.contentSize = CGSize.init(width: CGFloat(width), height: 0)

        }

        
    }
    
    func buttonClick(btn:UIButton) -> () {
        
        print(btn.tag)
    }
    
}

