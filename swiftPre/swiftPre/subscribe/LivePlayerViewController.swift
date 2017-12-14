//
//  LivePlayerViewController.swift
//  swiftPre
//
//  Created by apple on 2017/1/24.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit

class LivePlayerViewController: UIViewController ,UIScrollViewDelegate{
    
    var dataSource:[VideoLiveInfo]?
    var currentIndex:Int = 0
    let liveScrollView:UIScrollView = UIScrollView()
    let exitButton:UIButton = UIButton()
    var livePlayer:LivePlayerView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.

        view.addSubview(liveScrollView)
        liveScrollView.snp.makeConstraints { (snpMake) in
            snpMake.left.right.bottom.top.equalTo(self.view)
        }
        liveScrollView.showsVerticalScrollIndicator = false
        liveScrollView.showsHorizontalScrollIndicator = false
        liveScrollView.isPagingEnabled = true
        liveScrollView.delegate = self
        liveScrollView.contentSize = CGSize.init(width: 0, height: self.view.frame.height * 3)
        liveScrollView.contentOffset = CGPoint.init(x: 0, y: self.view.frame.height)

        for index:Int in 0...2 {
            print(index)
            let imageView:UIImageView = UIImageView()
            let oriGinX = CGFloat(Int(index) * Int(self.view.frame.size.height))
            imageView.tag = 10000 + index
            imageView.frame = CGRect.init(x: 0, y: oriGinX, width: ScreenWidth, height: ScreenHeight)
            liveScrollView.addSubview(imageView)
            if index == 1 {
                imageView.backgroundColor = UIColor.yellow
            }
            if index == 2 {
                imageView.backgroundColor = UIColor.red
            }
        }
        
        exitButton.setImage(UIImage.init(named: "talk_close_40x40_"), for: .normal)
        exitButton.addTarget(self, action: #selector(exitButtonClick), for: .touchUpInside)
        view.addSubview(exitButton)
        exitButton.snp.makeConstraints { (snpMake) in
            snpMake.top.equalTo(self.view).offset(20)
            snpMake.right.equalTo(self.view).offset(-20)
            snpMake.width.height.equalTo(40)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetImageData()
        resetLivePlayer()
    }
    
    func removeVideoPlayer() {
        if livePlayer != nil {
            livePlayer?.removeFromSuperview()
        }
    }
    
    func resetLivePlayer() {
        if self.currentIndex < 0 {
            self.currentIndex = (self.dataSource?.count)! - 1
        }
        let info:VideoLiveInfo = (self.dataSource?[self.currentIndex])!
        if livePlayer != nil {
            livePlayer?.stopTheVideo()
            livePlayer = nil
        }
        if info.flv != nil{
            livePlayer = LivePlayerView.init(frame: CGRect.init(x: 0, y: ScreenHeight, width: ScreenWidth, height: ScreenHeight), urlString: info.flv!)
            livePlayer?.playTheVideo()
            liveScrollView.addSubview(livePlayer!)
        }
        
    }
    
    //重置
    func resetImageData()  {
        for index:Int in 0...2 {
            let imageView:UIImageView = (liveScrollView.viewWithTag(10000 + index) as? UIImageView)!
            
            guard self.dataSource != nil else {
                return
            }
            guard (self.dataSource?.count)! > 0 else {
                return
            }
            guard self.currentIndex >= 0 && self.currentIndex < (self.dataSource?.count)! else {
                return
            }
            
            if self.currentIndex == 0 {
                let info:VideoLiveInfo = (self.dataSource?.last)!
                imageView.sd_setImage(with: URL.init(string: info.bigpic!))
                
            }
            if self.currentIndex == (self.dataSource?.count)! - 1 {
                let info:VideoLiveInfo = (self.dataSource?.first)!
                imageView.sd_setImage(with: URL.init(string: info.bigpic!))
            }
            if index == 0 {
                var index = self.currentIndex - 1
                if index < 0 {
                    index = (self.dataSource?.count)! - 1
                }
                let info:VideoLiveInfo = (self.dataSource?[index])!
                imageView.sd_setImage(with: URL.init(string: info.bigpic!))
            }
            if index == 1 {
                let info:VideoLiveInfo = (self.dataSource?[currentIndex])!
                imageView.sd_setImage(with: URL.init(string: info.bigpic!))
            }
            if index == 2 {
                var index = self.currentIndex + 1
                if index > (self.dataSource?.count)! {
                    index = 0
                }
                let info:VideoLiveInfo = (self.dataSource?[index])!
                imageView.sd_setImage(with: URL.init(string: info.bigpic!))
            }
        }
    }


    func exitButtonClick() -> () {
        livePlayer?.stopTheVideo()
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LivePlayerViewController{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index:Int = Int(scrollView.contentOffset.y / liveScrollView.frame.height)
        let imageView = liveScrollView.viewWithTag(10000 + index)
        if imageView == nil {
            print("weilovsdnbv")
        }
        imageView?.frame = CGRect.init(x: 0, y: ScreenHeight, width: ScreenWidth, height: ScreenHeight)
        var offIndex = 0
        
        if index == 0{
            let imageViewT = liveScrollView.viewWithTag(10001)
            imageViewT?.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
            imageViewT?.tag = 10000
            offIndex = -1
        }
        if index == 2{
            let imageViewT = liveScrollView.viewWithTag(10001)
            let heightX = ScreenHeight * 2
            imageViewT?.frame = CGRect.init(x: 0, y: heightX, width: ScreenWidth, height: ScreenHeight)
            imageViewT?.tag = 10002
            offIndex = 1
        }
        imageView?.tag = 10001
        if index != 1{
            self.removeVideoPlayer()
            liveScrollView.contentOffset = CGPoint.init(x: 0, y: liveScrollView.frame.height)
            loadLiveData(index: offIndex)
        }

    }
    
    func loadLiveData(index:Int) {
        self.currentIndex = self.currentIndex + index
        self.resetImageData()
        resetLivePlayer()
    }
}



