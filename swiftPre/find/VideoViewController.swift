//
//  VideoViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/21.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class VideoViewController: BaseFindViewController {

    
    var videoPlayer:VTVideoPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let button:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 100, width: 80, height: 80))
        button.backgroundColor = UIColor.purple
        button.addTarget(self, action: #selector(self.buttobClick(button:)), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(button)
        
        
        //写一个视频播放器
     
        videoPlayer = VTVideoPlayer.init(frame: CGRect.init(x: 10, y: 100, width: 300, height: 200),videoUrl:"http://ic.snssdk.com/neihan/video/playback/?video_id=a99b72468aa04916a2aceb5b19760fb8&quality=480p&line=0&is_gif=0.mp4")
        
        videoPlayer?.backgroundColor = UIColor.yellow
        videoPlayer?.showView = self.view
        self.view.addSubview(videoPlayer!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func scrollToCurrentViewContriller() {
        super.scrollToCurrentViewContriller()
        
        //点击
//        FunnyRequest().requestFunnyVideoList()
        
        
    }
    
    
    func buttobClick(button:UIButton) -> () {
        
        videoPlayer?.playVideo()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
