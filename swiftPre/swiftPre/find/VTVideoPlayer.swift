//
//  VTVideoPlayer.swift
//  SwiftTest
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import AVFoundation



class VTVideoPlayer: UIView {
    var vtPlayerLayer:AVPlayerLayer? // 显示视频 图层
    var vtPlayer:AVPlayer? //播放视频
    var vtPlayerItem:AVPlayerItem? //播放资源
    var videoUrlString:String?
    var playButton = UIButton()
    var controlView:UIView = UIView()
    var slider:UISlider = UISlider()
    var fullScreen:UIButton = UIButton()
    var videoTimer:Timer?
    var showView:UIView?
    var showFrame:CGRect?
    
    fileprivate var isCanPlay:Bool = false
    init(frame: CGRect,videoUrl:String) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        self.preparePlayVideo(urlStr: videoUrl)
        
    }
    
    //播放控制
    func preparePlayVideo(urlStr:String) {
        showFrame = self.frame
        videoUrlString = urlStr
        isCanPlay = false
        if videoUrlString != nil{
            vtPlayerItem = AVPlayerItem.init(url: URL.init(string: videoUrlString!)!)
            // 监听缓冲进度改变
            vtPlayerItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: NSKeyValueObservingOptions.new, context: nil)
            // 监听状态改变
            vtPlayerItem?.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
            vtPlayer = AVPlayer.init(playerItem: vtPlayerItem)
            vtPlayerLayer = AVPlayerLayer.init(player: vtPlayer)
            vtPlayerLayer?.frame = self.bounds
            vtPlayerLayer?.videoGravity = AVLayerVideoGravityResizeAspect
            vtPlayerLayer?.contentsScale = UIScreen.main.scale
            self.layer.addSublayer(vtPlayerLayer!)
            self.addSubview(playButton)
            self.setipUI()
            self.setTimer()
        }
    }
    
    func pauseVideo(){
        self.vtPlayer?.pause()
    }
    func stopVideo()  {
        self.vtPlayer?.pause()
        self.vtPlayer = nil
        self.vtPlayerLayer = nil
        self.vtPlayerLayer = nil
    }
    func playVideo() {
        //准备好播放
        if isCanPlay {
            if vtPlayer?.currentItem?.status == AVPlayerItemStatus.readyToPlay{
                self.vtPlayer?.play()
            }
        }
        isCanPlay = true

    }
    func removeVideoObserver() {
        vtPlayerItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
        vtPlayerItem?.removeObserver(self, forKeyPath: "status")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let playItem = object as? AVPlayerItem else {
            return
        }
        
        if keyPath == "loadedTimeRanges"{
            
        }else if keyPath == "status"{
            //监听状态改变
            if playItem.status == AVPlayerItemStatus.readyToPlay{
                // 只有在这个状态下才能播放
                if isCanPlay {
                    self.vtPlayer?.play()
                }
                isCanPlay = true
            }else{
                print("加载异常")
            }
        }
    }
    //MARK: 播放完成
    func finishedVideoPlayer() {
        self.videoTimer?.invalidate()
        self.videoTimer = nil
        self.removeVideoObserver() //移除通知
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


//试图创建
extension VTVideoPlayer{
    
    func setipUI() {
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.showButton))
        self.addGestureRecognizer(tap)
        
        playButton.frame = CGRect.init(x: self.frame.size.width / 2 - 25, y: self.frame.size.height / 2 - 50, width: 50, height: 50)
        playButton.setImage(UIImage.init(named: "blueSkyPlay"), for: UIControlState.normal)
        playButton.setImage(UIImage.init(named: "BMPlayer_pause"), for: UIControlState.selected)
        playButton.addTarget(self, action: #selector(self.pauseVideoButton(button:)), for: UIControlEvents.touchUpInside)
        
        controlView.frame = CGRect.init(x: 0, y: self.frame.size.height - 40, width: self.frame.size.width, height: 40)
        controlView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.addSubview(controlView)
        
        slider.frame = CGRect.init(x: 10, y: 0, width: controlView.frame.size.width - 60, height: 40)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 0
        // 从最大值滑向最小值时杆的颜色
        slider.maximumTrackTintColor = UIColor.init(red: 202 / 255.0, green: 202 / 255.0, blue: 202 / 255.0, alpha: 1.0)
        // 从最小值滑向最大值时杆的颜色
        slider.minimumTrackTintColor = UIColor.white
        // 在滑块圆按钮添加图片
        slider.setThumbImage(UIImage(named:"playerview_point"), for: UIControlState.normal)
        controlView.addSubview(slider)
        
        slider.addTarget(self, action: #selector(sliderTouchDown(slider:)), for: UIControlEvents.touchDown)
        // 弹起的时候
        slider.addTarget(self, action: #selector(sliderTouchUpOut(slider:)), for: UIControlEvents.touchUpOutside)
        slider.addTarget(self, action: #selector(sliderTouchUpOut(slider:)), for: UIControlEvents.touchUpInside)
        slider.addTarget(self, action: #selector(sliderTouchUpOut(slider:)), for: UIControlEvents.touchCancel)
        
        
        fullScreen.frame = CGRect.init(x:controlView.frame.size.width - 50 , y: 5, width: 40, height: 40)
        
        fullScreen.setImage(UIImage.init(named: "expansiongraph"), for: UIControlState.normal)
        fullScreen.setImage(UIImage.init(named: "expansiongraph"), for: UIControlState.selected)
        fullScreen.addTarget(self, action: #selector(self.fullScreenButtonClick(button:)), for: UIControlEvents.touchUpInside)
        controlView.addSubview(fullScreen)
        
    }
    
    
    func fullScreenButtonClick(button:UIButton) {
        
        
        if button.isSelected {
            button.isSelected = false
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UIApplication.shared.setStatusBarHidden(false, with: .fade)
            UIApplication.shared.statusBarOrientation = .portrait
            UIView.animate(withDuration: 0.5, animations: {
                self.frame = self.showFrame!
                if self.showView != nil{
                    self.showView?.addSubview(self)
                }
            })
            self.reLayoutViewUI(across: false)
        }else{
            button.isSelected = true
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            UIApplication.shared.setStatusBarHidden(false, with: .fade)
            UIApplication.shared.statusBarOrientation = .landscapeRight
            
            UIView.animate(withDuration: 0.5, animations: {
                self.frame = CGRect.init(x: 0, y: 0, width:ScreenHeight, height:ScreenWidth )

                let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
                appDelegate.window?.addSubview(self)
                
            })
            
            print(ScreenWidth)
            self.reLayoutViewUI(across: true)
        }
    }
    //MARK: 全屏， 界面UI重置
    func reLayoutViewUI(across:Bool) {
        vtPlayerLayer?.frame = self.bounds
        if across{
            playButton.frame = CGRect.init(x: (self.frame.size.width - 50) / 2, y: (self.frame.size.height - 50) / 2, width:50, height: 50)
            playButton.backgroundColor = UIColor.purple
            controlView.frame = CGRect.init(x: 0, y: self.frame.size.height - 40, width: self.frame.size.width, height: 40)
            
            slider.frame = CGRect.init(x: 10, y: 0, width: controlView.frame.size.width - 60, height: 40)
            fullScreen.frame = CGRect.init(x:controlView.frame.size.width - 50 , y: 5, width: 30, height: 30)
        }else
        {
            playButton.frame = CGRect.init(x: self.frame.size.width / 2 - 25, y: self.frame.size.height / 2 - 50, width: 50, height: 50)
            controlView.frame = CGRect.init(x: 0, y: self.frame.size.height - 40, width: self.frame.size.width, height: 40)
            slider.frame = CGRect.init(x: 10, y: 0, width: controlView.frame.size.width - 60, height: 40)
            fullScreen.frame = CGRect.init(x:controlView.frame.size.width - 50 , y: 5, width: 30, height: 30)
        }

    }
    
    func pauseVideoButton(button:UIButton) {
        if button.isSelected {
            self.pauseVideo()
            button.isSelected = false
        }else{
            
            self.playVideo()
            button.isSelected = true
        }
        //延时3秒执行
        let time: TimeInterval = 3.0
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + time, execute: {
            DispatchQueue.main.async {
                self.playButton.isHidden = true
            }
            
        })
    }
    func showButton() {
        
        if playButton.isHidden{
            playButton.isHidden = false
            controlView.isHidden = false
            //延时3秒执行
            let time: TimeInterval = 4.0
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + time, execute: {
                DispatchQueue.main.async {
                    self.playButton.isHidden = true
                    self.controlView.isHidden = true
                }
            })
            
        }else{
            playButton.isHidden = true
            controlView.isHidden = true
        }
    }
    

}

//试图更新
extension VTVideoPlayer{
    //MARK:  设置定时器
    func setTimer(){
        videoTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerChanged(timer:)), userInfo: nil, repeats: true)
    }
    func timerChanged(timer:Timer){
        
        guard let currentTimer = vtPlayer?.currentTime().value else {
            return
        }
        
        guard let currentScale = vtPlayer?.currentTime().timescale else {
            return
        }
        guard let totocalTime = vtPlayer?.currentItem?.duration.value else {
            return
        }
        guard let totocalScale = vtPlayer?.currentItem?.duration.timescale else {
            return
        }
        if totocalScale == 0 {
            return
        }
        if Int(currentScale) == 0  {
            return
        }
        
        let cuTime = Int( currentTimer ) / Int(currentScale)
        let during:Int = Int(totocalTime) / Int(totocalScale)
        let value:Float = Float(cuTime) / Float(during) * 100
        
        slider.value = value
        
        if value == 100 {
            //播放完成
            self.videoTimer = nil
        }
    }
    
    //MARK:  UISlider 状态改变
    func sliderTouchDown(slider:UISlider){
        //按下的时候
        self.vtPlayer?.pause()
    }
    func sliderTouchUpOut(slider:UISlider){
        //弹起的时候
        guard let totocalTime = vtPlayer?.currentItem?.duration.value else {
            return
        }
        guard let totocalScale = vtPlayer?.currentItem?.duration.timescale else {
            return
        }
        if totocalScale == 0  {
            return
        }
        let during:Int = Int(totocalTime) / Int(totocalScale)
        let seekTime:Double = Double (slider.value / 100) * Double(during)
        
        self.vtPlayer?.seek(to: CMTime.init(seconds:seekTime, preferredTimescale: totocalScale))
        self.vtPlayer?.play()
        
    }
}

