//
//  FindViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/16.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import StreamingKit

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height


class FindViewController: UIViewController,PageControllDelegate,PageContentViewDelegate,ScrollEndIndexDelegate {

    //多视图控制
    fileprivate lazy var viewControllerTitles:[String] = {
        let array = ["推荐","视频","段子","直播","百度","广播","新闻"]
        return array
    }()
    
    fileprivate lazy var VCManage:[BaseFindViewController] = {
       let array = [RecommendViewController(),VideoViewController(),FunnyViewController(),LiveViewController(),BaiduViewController(),BroadcastViewController(),NewsViewController()]
        return array
    }()
    
    var pageControll:PageControlView?
    
    var pageContent:PageContentView?
    
    var animationImageView = UIImageView()
    let MusciChanged_Playering = Notification.Name(rawValue:"MusciChanged_Playering")
    let MusciChanged_Pause = Notification.Name.init(rawValue:"MusciChanged_Pause")
    let MusciChanged_Stop = Notification.Name.init(rawValue:"MusciChanged_Stop")
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white

        
        //创建 控制条
        pageControll = PageControlView.init(frame: CGRect.init(x: 0, y: 64, width: self.view.bounds.width, height: 44), currentIndex: 0, titles: self.viewControllerTitles)
        pageControll?.delegate = self
        self.view.addSubview(pageControll!)
        
        //创建 content view
        pageContent = PageContentView.init(frame: CGRect.init(x: 0, y: (pageControll?.frame.size.height)! + (pageControll?.frame.origin.y)!, width: self.view.bounds.width, height: self.view.bounds.height - 44 - 64), vcArray: VCManage, index: 0)

        pageContent?.delegate = self
        pageContent?.endScrollDelegate = self
        self.view.addSubview(pageContent!)
        
        //添加到子试图控制器中
        for viewCpontroller in self.VCManage {
          self.addChildViewController(viewCpontroller)
        }
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationSongPlay), name: MusciChanged_Playering, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationSongPause), name: MusciChanged_Pause, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationSongPause), name: MusciChanged_Stop, object: nil)
        
        self.setRightNavButtonItem()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        
        if AudioModel.sharedInstanced.audioPlay.state == STKAudioPlayerState.playing {
            animationImageView.startAnimating()
        }else{
            animationImageView.stopAnimating()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //添加 跳动效果
    
    func setRightNavButtonItem() {
        
        animationImageView.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        let imageArray:Array<UIImage> = [UIImage.init(named: "NavBar_animation_frame1.png")!,UIImage.init(named: "NavBar_animation_frame2.png")!,UIImage.init(named: "NavBar_animation_frame3.png")!,UIImage.init(named: "NavBar_animation_frame4.png")!,UIImage.init(named: "NavBar_animation_frame5.png")!,UIImage.init(named: "NavBar_animation_frame6.png")!]
        animationImageView.animationImages = imageArray
        animationImageView.animationRepeatCount = 10000000
        animationImageView.animationDuration = 0.65
        animationImageView.startAnimating()
        let button = UIButton.init()
        button.setImage(UIImage.init(named: "NavBar_animation_frame6.png"), for: UIControlState.normal)
        button.frame = animationImageView.frame
        button.addSubview(animationImageView)
        button.addTarget(self, action: #selector(self.gotoPlayViewController), for: UIControlEvents.touchUpInside)
        
        let rightItem = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    
    func notificationSongPlay() {
        animationImageView.startAnimating()
    }
    func notificationSongPause() {
        animationImageView.stopAnimating()
    }
    
    func gotoPlayViewController() {
        self.navigationController?.pushViewController(SongPlayerViewController(), animated: true)
    }
    
}

//MARK:  controlDelegate
extension FindViewController{
    //点击按钮代理
    func scrollToObjectivePosition(toIndex: Int, fromIndex: Int) {
        
        pageContent?.setScrollViewContentOffSet(index: toIndex)
        //点击到某个
        //滚动到那个viewController
        let toVc = self.VCManage[toIndex];
        toVc.scrollToCurrentViewContriller()
        toVc.beginAppearanceTransition(true, animated: false)
        
    }
    
    //滚动代理
    func pageContentView(_ contentView: PageContentView, sourceIndex: Int, toIndex: Int, progress: CGFloat) {
        pageControll?.setLineFrame(progress: progress, fromIndex: sourceIndex, toIndex: toIndex)
        
    }
    func scrollToIndex(toIndex: Int, fromIndex: Int) {
        let toVc = self.VCManage[toIndex];
        
        toVc.scrollToCurrentViewContriller()
        toVc.beginAppearanceTransition(true, animated: false)
    }
    
}

