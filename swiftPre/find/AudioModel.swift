//
//  AudioModel.swift
//  SwiftTest
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import StreamingKit
import MediaPlayer

enum MusicPlayState {
    case playing
    case pause
    case stop
}

class AudioModel: NSObject ,STKAudioPlayerDelegate{

    //设置成单例
    static let sharedInstanced:AudioModel = AudioModel()
    fileprivate var songList:Array<SongInfo> = Array()
    fileprivate var currentIndex:Int = 0 // 当前播放的第一首
    //播放器
    var audioPlay:STKAudioPlayer = STKAudioPlayer()
    public var currentSongInfo:SongInfo?
    
    //通知
    let notificationCenter = NotificationCenter.default
    
    let MusciChanged_Playering = Notification.Name(rawValue:"MusciChanged_Playering")
    let MusciChanged_Pause = Notification.Name.init(rawValue:"MusciChanged_Pause")
    let MusciChanged_Stop = Notification.Name.init(rawValue:"MusciChanged_Stop")
    
    var radioPlayer:MPMoviePlayerViewController?
    
    var playState:MusicPlayState = .stop
    
    
    //播放音频
    fileprivate func playAudio(urlString:String?) {
        
        if self.radioPlayer?.moviePlayer.playbackState == MPMoviePlaybackState.playing {
            self.radioPlayer?.moviePlayer.pause()
        }
        let userInfo = ["songInfo":currentSongInfo]
        notificationCenter.post(name: MusciChanged_Playering, object: nil, userInfo: userInfo)
        if urlString != nil {
            audioPlay.play(urlString!)
        }else{
            print("播放失败")
        }
        audioPlay.delegate = self
        
        self.setLockView()
    }
    
    func resumePlayer() {
        if currentSongInfo?.isLive == true{
            radioPlayer?.moviePlayer.play()
        }else{
            audioPlay.resume()
        }
    }
    //暂停
    func pauseAudio() {
        if currentSongInfo?.isLive == true{
            radioPlayer?.moviePlayer.pause()
        }else{
            audioPlay.pause()
        }
        notificationCenter.post(name: MusciChanged_Pause, object: nil, userInfo: nil)
    }
    
    //暂停
    func stopAudio() {
        audioPlay.stop()
        notificationCenter.post(name: MusciChanged_Stop, object: nil, userInfo: nil)
    }
    //上一首
    func previousAudio() {
        if self.currentIndex != 0 {
            self.currentIndex = self.currentIndex - 1

        }else{
            self.currentIndex = self.songList.count - 1
        }
        
        let songInfo:SongInfo = self.songList[self.currentIndex]
        currentSongInfo = songInfo
        self.playAudio(urlString: songInfo.playUrl)
    }
    
    //快进到哪一点
    func seekToTime(toTime:Double) {
        audioPlay.seek(toTime: toTime)
    }
    
    //下一首
    func nextAudio() {
        if self.currentIndex == self.songList.count || self.currentIndex > self.songList.count {
            self.currentIndex = 0
        }else{
            self.currentIndex = self.currentIndex + 1
            
        }
        let songInfo:SongInfo = self.songList[self.currentIndex]
        currentSongInfo = songInfo
        self.playAudio(urlString: songInfo.playUrl)
        
        
    }
    //播放专辑
    func playAudioList(songList:Array<SongInfo>,index:Int) {
        self.songList = songList
        self.currentIndex = index
        if self.songList.count > self.currentIndex {
            let songInfo:SongInfo = self.songList[index]
            currentSongInfo = songInfo
            self.playAudio(urlString: songInfo.playUrl)
        }
    }
    
    //播放直播
    func livePlaying(info:SongInfo,showInView:UIView ){
        guard info.playUrl != nil else {
            return
        }
        radioPlayer = MPMoviePlayerViewController.init(contentURL: URL.init(string: info.playUrl!))
        let playerLayer = radioPlayer?.moviePlayer
        playerLayer?.controlStyle = .none
        playerLayer?.view.frame = CGRect.zero
        showInView.addSubview((playerLayer?.view)!)
        playerLayer?.play()
        currentSongInfo = info
        
        let userInfo = ["songInfo":currentSongInfo]
        notificationCenter.post(name: MusciChanged_Playering, object: nil, userInfo: userInfo)
        
        if self.audioPlay.state == .playing {
            self.pauseAudio()
        }
    }
}

extension AudioModel{
    
    //MARK: STKAudioPlayerDelegate
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, stateChanged state: STKAudioPlayerState, previousState: STKAudioPlayerState) {
        
        print("state ======= \(state)")
        if state == STKAudioPlayerState.stopped{
            self.nextAudio()
            
        }
        
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, logInfo line: String) {
        
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didStartPlayingQueueItemId queueItemId: NSObject) {
        
    } 
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didCancelQueuedItems queuedItems: [Any]) {
        
    }
    func audioPlayer(_ audioPlayer: STKAudioPlayer, unexpectedError errorCode: STKAudioPlayerErrorCode) {
        
    }
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishBufferingSourceWithQueueItemId queueItemId: NSObject) {
        
    }
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishPlayingQueueItemId queueItemId: NSObject, with stopReason: STKAudioPlayerStopReason, andProgress progress: Double, andDuration duration: Double) {
        
        
        print(queueItemId,progress)
    }
    
}


extension AudioModel{
    //MARK: 设置锁屏控制界面
    func setLockView(){
        DispatchQueue.global().async {
            var songName:String!
            if AudioModel.sharedInstanced.currentSongInfo?.name == nil {
                songName = " "
            }else{
                songName = (AudioModel.sharedInstanced.currentSongInfo?.name!)!
            }
            var albumName:String!
            if AudioModel.sharedInstanced.currentSongInfo?.columnName == nil {
                albumName = " "
            }else{
               albumName = (AudioModel.sharedInstanced.currentSongInfo?.columnName!)!
            }
            
            var logoPic:String!
            if AudioModel.sharedInstanced.currentSongInfo?.logoUrl == nil {
                logoPic = " "
            }else{
                logoPic = (AudioModel.sharedInstanced.currentSongInfo?.logoUrl!)!
            }
            
            let logoUrl = URL.init(string: logoPic)!
            let dataLogo = NSData.init(contentsOf: logoUrl)
            guard dataLogo != nil else {
                return
            }
            let image = UIImage.init(data: dataLogo as! Data)
            guard image != nil else {
                return
            }
            DispatchQueue.main.async {
                MPNowPlayingInfoCenter.default().nowPlayingInfo = [
                    // 歌曲名称
                    MPMediaItemPropertyTitle:songName,
                    // 演唱者
                    MPMediaItemPropertyArtist:albumName,
                    // 锁屏图片
                    MPMediaItemPropertyArtwork:MPMediaItemArtwork(image: image!),
                    //
                    MPNowPlayingInfoPropertyPlaybackRate:1.0,
                    // 总时长            MPMediaItemPropertyPlaybackDuration:audioPlayer.duration,
                    // 当前时间        MPNowPlayingInfoPropertyElapsedPlaybackTime:audioPlayer.currentTime
                ]
            }
        }
        
    }
    

}


