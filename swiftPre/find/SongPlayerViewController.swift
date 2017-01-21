//
//  SongPlayerViewController.swift
//  swiftPre
//
//  Created by apple on 2017/1/5.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit
import StreamingKit

class SongPlayerViewController: UIViewController,UIGestureRecognizerDelegate {

    fileprivate var backButton:UIButton = UIButton()
    fileprivate var backgroundImageView:UIImageView = UIImageView()
    fileprivate var titleLabel:UILabel = UILabel()
    fileprivate var rotImageView:UIImageView = UIImageView()
    fileprivate var rotBgImageView:UIImageView = UIImageView()
    fileprivate var controlView:UIView = UIView()
    fileprivate var backPlay = UIButton()
    fileprivate var pausePlay = UIButton()
    fileprivate var nextPlay = UIButton()
    fileprivate var sliderView = UISlider()
    //通知
    let MusciChanged_Playering = Notification.Name(rawValue:"MusciChanged_Playering")
    let MusciChanged_Pause = Notification.Name.init(rawValue:"MusciChanged_Pause")
    let MusciChanged_Stop = Notification.Name.init(rawValue:"MusciChanged_Stop")

    fileprivate var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        self.loadData()
        // Do any additional setup after loading the view.
        
        weak var weakSelf:SongPlayerViewController? = self

        let time: TimeInterval = 10.0
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + time, execute: {
            if weakSelf == nil{
                print("已经释放")
            }else{
                print("没有释放")
            }
        })
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationSongPlay), name: MusciChanged_Playering, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationSongPause), name: MusciChanged_Pause, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationSongPause), name: MusciChanged_Stop, object: nil)
        
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer:Timer) in
                let during:Double = AudioModel.sharedInstanced.audioPlay.duration
                let currentValue:Double = AudioModel.sharedInstanced.audioPlay.progress
                let seekTime:Double = currentValue / during * 100
                weakSelf?.sliderView.value = Float(seekTime)
            })
        } else {
            // Fallback on earlier versions
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerChanged(timer:)), userInfo: nil, repeats: true)
        }
    }
    func timerChanged(timer:Timer) {
        
        let during:Double = AudioModel.sharedInstanced.audioPlay.duration
        let currentValue:Double = AudioModel.sharedInstanced.audioPlay.progress
        let seekTime:Double =  currentValue / during * 100
        sliderView.value = Float(seekTime)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupUI() {
        self.view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (snpMake) in
            snpMake.top.bottom.left.right.equalTo(self.view)
        }
        //模糊效果
        let blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView.init(effect: blurEffect)
        backgroundImageView.addSubview(blurView)
        blurView.snp.makeConstraints { (snpMake) in
            snpMake.top.bottom.left.right.equalTo(backgroundImageView)
        }
        
        backButton.backgroundColor = UIColor.clear
        backButton.setImage(UIImage.init(named: "back_9x16"), for: UIControlState.normal)
        backButton.setImage(UIImage.init(named: "back_9x16"), for: UIControlState.selected)
        backButton.addTarget(self, action: #selector(self.backToPreVC), for: UIControlEvents.touchUpInside)
        self.view.addSubview(backButton)
        backButton.snp.makeConstraints { (snpMake) in
            snpMake.left.top.equalTo(self.view)
            snpMake.width.height.equalTo(64)
        }
        backButton.imageEdgeInsets = UIEdgeInsets.init(top: 20, left: 5, bottom: 0, right: 0)
        
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (snpMake) in
            snpMake.left.equalTo(backButton.snp.right)
            snpMake.right.equalTo(self.view).offset(-64)
            snpMake.top.equalTo(self.view).offset(20)
            snpMake.bottom.equalTo(backButton)
        }
        
        rotBgImageView.image = UIImage.init(named: "playerview_icn_play_disc.png")
        self.view.addSubview(rotBgImageView)
        rotBgImageView.snp.makeConstraints { (snpMake) in
            snpMake.left.equalTo(self.view).offset(40)
            snpMake.right.equalTo(self.view).offset(-40)
            snpMake.top.equalTo(titleLabel.snp.bottom).offset(80)
            snpMake.height.equalTo(rotBgImageView.snp.width)
        }
        
        self.view.addSubview(rotImageView)
        rotImageView.snp.makeConstraints { (snpMake) in
            snpMake.left.top.equalTo(rotBgImageView).offset(60)
            snpMake.bottom.right.equalTo(rotBgImageView).offset(-60)
        }
        rotImageView.clipsToBounds = true
        rotImageView.layer.cornerRadius = ScreenWidth / 2 - 100
        
        self.rotImageViewAnimation()
        
        controlView.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.4)
        self.view.addSubview(controlView)
        controlView.snp.makeConstraints { (snpMake) in
            snpMake.left.right.equalTo(self.view)
            snpMake.bottom.equalTo(self.view).offset(-60)
            snpMake.height.equalTo(100)
        }

        backPlay.setImage(UIImage.init(named: "playerview_btn_last"), for: UIControlState.normal)
        backPlay.setImage(UIImage.init(named: "playerview_btn_last"), for: UIControlState.selected)
        pausePlay.setImage(UIImage.init(named: "playerview_btn_pause"), for: UIControlState.normal)
        pausePlay.setImage(UIImage.init(named: "playerview_btn_play"), for: UIControlState.selected)
        nextPlay.setImage(UIImage.init(named: "playerview_btn_next"), for: UIControlState.normal)
        nextPlay.setImage(UIImage.init(named: "playerview_btn_next"), for: UIControlState.selected)
        backPlay.tag = 1000
        pausePlay.tag = 1001
        nextPlay.tag = 1002
        backPlay.addTarget(self, action: #selector(buttonClick(button:)), for: UIControlEvents.touchUpInside)
        pausePlay.addTarget(self, action: #selector(buttonClick(button:)), for: UIControlEvents.touchUpInside)
        nextPlay.addTarget(self, action: #selector(buttonClick(button:)), for: UIControlEvents.touchUpInside)
        controlView.addSubview(backPlay)
        controlView.addSubview(pausePlay)
        controlView.addSubview(nextPlay)
        
        controlView.addSubview(sliderView)
        sliderView.snp.makeConstraints { (snpMake) in
            snpMake.left.equalTo(controlView).offset(40)
            snpMake.right.equalTo(controlView).offset(-40)
            snpMake.bottom.equalTo(controlView).offset(-10)
            snpMake.height.equalTo(20)
        }
        sliderView.minimumValue = 0
        sliderView.maximumValue = 100
        sliderView.value = 0
        // 从最小值滑向最大值时杆的颜色
        sliderView.maximumTrackTintColor = UIColor.white
        sliderView.minimumTrackTintColor = UIColor.init(red: 20 / 255.0, green: 122 / 255.0, blue: 1.0, alpha: 1.0)
        // 在滑块圆按钮添加图片
        sliderView.setThumbImage(UIImage(named:"playerview_progresspoint.png"), for: UIControlState.normal)
        
        
        sliderView.addTarget(self, action: #selector(sliderTouchDown(slider:)), for: UIControlEvents.touchDown)
        // 弹起的时候
        sliderView.addTarget(self, action: #selector(sliderTouchUpOut(slider:)), for: UIControlEvents.touchUpOutside)
        sliderView.addTarget(self, action: #selector(sliderTouchUpOut(slider:)), for: UIControlEvents.touchUpInside)
        sliderView.addTarget(self, action: #selector(sliderTouchUpOut(slider:)), for: UIControlEvents.touchCancel)
        
        
        let oriX = (ScreenWidth - 120) / 4
        backPlay.snp.makeConstraints { (snpMake) in
            snpMake.centerY.equalTo(controlView).offset(-15)
            snpMake.width.height.equalTo(40)
            snpMake.left.equalTo(self.view).offset(oriX)
        }
        pausePlay.snp.makeConstraints { (snpMake) in
            snpMake.centerY.equalTo(backPlay)
            snpMake.width.height.equalTo(backPlay)
            snpMake.left.equalTo(backPlay.snp.right).offset(oriX)
        }
        nextPlay.snp.makeConstraints { (snpMake) in
            snpMake.centerY.equalTo(backPlay)
            snpMake.width.height.equalTo(backPlay)
            snpMake.left.equalTo(pausePlay.snp.right).offset(oriX)
        }
        
        weak var weakSelf:SongPlayerViewController? = self
        let time: TimeInterval = 3.0
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + time, execute: {
            DispatchQueue.main.async {
                
                if AudioModel.sharedInstanced.audioPlay.state == STKAudioPlayerState.playing {
                    weakSelf?.pausePlay.isSelected = false
                }else{
                    weakSelf?.pausePlay.isSelected = true
                }
            }
            
        })
    }
    
    func loadData() {
        
        if AudioModel.sharedInstanced.currentSongInfo != nil {
            let songInfo  = AudioModel.sharedInstanced.currentSongInfo!
            if songInfo.logoUrl != nil {
                backgroundImageView.sd_setImage(with: URL.init(string: songInfo.logoUrl!), placeholderImage: UIImage.init(named: "player_backgroundImage_568h.jpg"))
                rotImageView.sd_setImage(with: URL.init(string: songInfo.logoUrl!), placeholderImage: UIImage.init(named: "player_backgroundImage_568h.jpg"))
                
            }else{
                backgroundImageView.image = UIImage.init(named: "player_backgroundImage_568h.jpg")
                rotImageView.image = UIImage.init(named: "player_backgroundImage_568h.jpg")
            }
            titleLabel.text = songInfo.name
        }
    }
    
    func buttonClick(button:UIButton) {
        
        switch button.tag {
        case 1000:
            //上一首
             AudioModel.sharedInstanced.previousAudio()
             break
        case 1001:
            if button.isSelected {
                button.isSelected = false
                AudioModel.sharedInstanced.resumePlayer()
            }else{
                button.isSelected = true
                AudioModel.sharedInstanced.pauseAudio()
            }
             break
        case 1002:
             AudioModel.sharedInstanced.nextAudio()
             break
        default:
             break
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //注意下面一条语句将系统的手势会屏弊掉,如果没有下面的一条语句拖动边缘是可以返回去的
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //依然保持手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        super.viewWillAppear(animated)

    }
    func notificationSongPlay() {
        pausePlay.isSelected = false
        
        self.loadData()
    }
    func notificationSongPause() {
        pausePlay.isSelected = true
    }
    
    func backToPreVC() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    func rotImageViewAnimation() {
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animation.fromValue = 0.0
        animation.toValue   = M_PI * 2
        animation.duration = 13
        animation.autoreverses = false
        animation.fillMode = kCAFillModeForwards
        animation.repeatCount = 100000000
        rotImageView.layer.add(animation, forKey: nil)
    }
    
    func sliderTouchUpOut(slider:UISlider){
        //弹起的时候
        let during:Double = AudioModel.sharedInstanced.audioPlay.duration
        let seekTime:Double = Double (slider.value / 100) * during
        AudioModel.sharedInstanced.seekToTime(toTime: seekTime)
        AudioModel.sharedInstanced.resumePlayer()
        
    }
    func sliderTouchDown(slider:UISlider){
        //按下的时候
        AudioModel.sharedInstanced.pauseAudio()
    }
    
    
    
}
