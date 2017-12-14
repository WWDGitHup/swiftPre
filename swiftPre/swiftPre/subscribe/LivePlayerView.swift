//
//  LivePlayerView.swift
//  swiftPre
//
//  Created by apple on 2017/2/4.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit
import IJKMediaFramework

class LivePlayerView: UIView {

    var livePlayer:IJKFFMoviePlayerController!
    
    init(frame: CGRect, urlString:String) {
        super.init(frame: frame)
        let url =  URL.init(string: urlString)
        let player = IJKFFMoviePlayerController.init(contentURL: url, with: IJKFFOptions.byDefault())
        //播放页面视图宽高自适应
        let autoresize = UIViewAutoresizing.flexibleWidth.rawValue | UIViewAutoresizing.flexibleHeight.rawValue
        player?.view.autoresizingMask = UIViewAutoresizing(rawValue: autoresize)
        player?.view.frame = self.bounds
        player?.scalingMode = .aspectFit //缩放模式
        player?.shouldAutoplay = true //开启自动播放
        self.autoresizesSubviews = true
        self.addSubview((player?.view)!)
        self.livePlayer = player
    }
    
    func playTheVideo()  {
       self.livePlayer.prepareToPlay()
    }
    
    func stopTheVideo() {
        self.livePlayer.shutdown()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
