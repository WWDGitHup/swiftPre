//
//  FunnyVideoCell.swift
//  SwiftTest
//
//  Created by apple on 2016/12/28.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import TangramKit
import BMPlayer
import NVActivityIndicatorView

class FunnyVideoCell: UITableViewCell,BMPlayerDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public let PlayerWillFinishedNotication = NSNotification.Name.init("PlayerWillFinishedNotication")
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate let headImageView:UIImageView = UIImageView()
    fileprivate let titleLabel:UILabel = UILabel()
    fileprivate let contentLabel:UILabel = UILabel()
    fileprivate let contentButton:UIButton = UIButton()
    fileprivate var funnyInfo:FunnyRecommendModel?
    var videoPlayer:BMPlayer!
    var indexPath:IndexPath?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(stopVideo), name: PlayerWillFinishedNotication, object: nil)
        
        headImageView.frame = CGRect.init(x: 15, y: 10, width: 60, height: 60)
        headImageView.layer.cornerRadius = 30
        headImageView.clipsToBounds = true
        self.addSubview(headImageView)
        
        contentButton.setImage(UIImage.init(named: "BMPlayer_play"), for: UIControlState.normal)
        contentButton.setImage(UIImage.init(named: "BMPlayer_pause"), for: UIControlState.selected)
        contentButton.backgroundColor = UIColor.black
        contentButton.addTarget(self, action: #selector(self.playVideoUrlY(button:)), for: UIControlEvents.touchUpInside)
        
        self.addSubview(contentButton)

        titleLabel.frame = CGRect.init(x: headImageView.frame.size.width +  headImageView.frame.origin.x + 10, y: headImageView.frame.origin.y, width: self.frame.size.width - headImageView.frame.size.width - headImageView.frame.origin.x * 3, height: headImageView.frame.height)
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor.darkGray
        self.addSubview(titleLabel)
    
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textColor = UIColor.init(red: 53 / 255.0, green: 53 / 255.0, blue: 53 / 255.0, alpha: 1.0)
        contentLabel.numberOfLines = 100000
        self.addSubview(contentLabel)
        
        // player.panGesture.isEnabled = false
        self.layoutIfNeeded()

    }
    
    
    func loadVideoData(model:FunnyRecommendModel){
        
        contentLabel.text = ""
        titleLabel.text = ""
        guard let groupf = model.group else {
            return
        }
        funnyInfo = model
        if groupf.content != nil{
            if groupf.content == ""
            {
                contentLabel.frame = CGRect.zero
            }else{
                let width = self.frame.size.width - headImageView.frame.origin.x * 2
                
                let heightString = groupf.content?.getStringHeight(font: UIFont.systemFont(ofSize: 14), limitWidth: width)
                
                contentLabel.frame = CGRect.init(x: headImageView.frame.origin.x, y: headImageView.frame.origin.y + headImageView.frame.size.height + 10, width: self.frame.size.width - headImageView.frame.origin.x * 2, height: heightString! + 5)
                contentLabel.text = groupf.content
            }

        }else{
            contentLabel.frame = CGRect.zero
        }

        if  model.group?.user?.avatar_url != nil {
            headImageView.sd_setImage(with: URL.init(string: (model.group?.user?.avatar_url)!))
        }
        titleLabel.text = model.group?.user?.name
        

        //宽高比
        if groupf.video_height != 0{
           
            let rate:Float = Float(groupf.video_width!) / Float(groupf.video_height!)
            
            var imageHeight = Float(self.frame.size.width - headImageView.frame.origin.x * 2) / rate
            if imageHeight > 350 {
                imageHeight = 350
            }
            let width = self.frame.size.width - headImageView.frame.origin.x * 2
            
            var heightString = groupf.content?.getStringHeight(font: UIFont.systemFont(ofSize: 14), limitWidth: width)
            if contentLabel.frame.size.height == 0 {
                heightString = heightString! - 10
            }
            contentButton.frame = CGRect.init(x: headImageView.frame.origin.x, y: headImageView.frame.origin.y + headImageView.frame.size.height + 20 + heightString!, width: self.frame.size.width - headImageView.frame.origin.x * 2, height: CGFloat(imageHeight))
        }
        
        if groupf.media_type == 3 {
           // 1 大图 2Gif 3 视频 4 小图 5精华
        }
        
        if funnyInfo?.group?.mp4_url == PlayerModel.sharedInstanced.currentPlayerUrl && funnyInfo?.group?.mp4_url != nil{
            print("当前cell正在播放")
             contentButton.isHidden = true
            if videoPlayer != nil {
                videoPlayer.isHidden = false
            }
            
        }else{
             contentButton.isHidden = false
            if videoPlayer != nil {
                videoPlayer.isHidden = true
            }
        }

    }
    
    //初始化播放器
    func resetPlayerManager() {
        BMPlayerConf.allowLog = false
        //自动播放
        BMPlayerConf.shouldAutoPlay = true
        BMPlayerConf.tintColor = UIColor.white
        BMPlayerConf.topBarShowInCase = .none
        
        BMPlayerConf.loaderType  = NVActivityIndicatorType.ballRotateChase
        videoPlayer = BMPlayer()
        self.addSubview(videoPlayer)
        videoPlayer.delegate = self
        videoPlayer.panGesture.isEnabled = false
        videoPlayer.playStateDidChange = { (isPlaying: Bool) in
            print("| BMPlayer Block | playStateDidChange \(isPlaying)")
            
        }
        
        //Listen to when the play time changes
        videoPlayer.playTimeDidChange = { (currentTime: TimeInterval, totalTime: TimeInterval) in
            print("| BMPlayer Block | playTimeDidChange currentTime: \(currentTime) totalTime: \(totalTime)")
        }
        
        videoPlayer.frame = contentButton.frame
    }
    
    
    func playVideoUrlY(button:UIButton) {
        if funnyInfo?.group?.mp4_url != nil{
            self.resetPlayerManager()
            let source = BMPlayerItemDefinitionItem(url: URL.init(string: (funnyInfo?.group?.mp4_url)!)!, definitionName: "标清")
            let item  = BMPlayerItem(title: "搞笑视频", resource: [source], cover: "http://img.wdjimg.com/image/video/447f973848167ee5e44b67c8d4df9839_0_0.jpeg")
            videoPlayer.playWithPlayerItem(item)
            PlayerModel.sharedInstanced.currentIndex =  self.indexPath?.row
            PlayerModel.sharedInstanced.currentPlayerUrl = funnyInfo?.group?.mp4_url
            
        }
    }
    
    func stopVideo() {
        
        if videoPlayer != nil && videoPlayer.isPlaying {
            videoPlayer.pause()
            videoPlayer.removeFromSuperview()
            videoPlayer = nil
            contentButton.isHidden = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension  FunnyVideoCell{
    //MARK:    bmPlayer delegate
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        
    }
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        
        print(state)
        
        if state == BMPlayerState.playedToTheEnd {
            self.stopVideo()
        }
        
    }
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        
    }

}



