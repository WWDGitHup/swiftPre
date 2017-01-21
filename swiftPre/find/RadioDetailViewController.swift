//
//  RadioDetailViewController.swift
//  swiftPre
//
//  Created by apple on 2017/1/6.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit
import MediaPlayer

class RadioDetailViewController: UIViewController ,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,HeaderReusableViewDelegate {

    fileprivate var radioTableView:UITableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
    fileprivate var dataSources:Array<RadioListDeatil>?
    fileprivate var headView = UIView()
    fileprivate var blurryImageView:UIImageView = UIImageView()
    fileprivate var smallImageView:UIImageView = UIImageView()
    fileprivate let headViewHeight:CGFloat = 220.0
    fileprivate let detailIndentifier = "detailIndentifier"
    fileprivate let programIndentifier = "programIndentifier"
    fileprivate var navbarView:UIView = UIView()
    public var radioInfo:RadioInfoModel?
    fileprivate var titleLabel:UILabel = UILabel()
    fileprivate var playButton:UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.setupUI()
    }
    
    func setupUI() {
        
        view.addSubview(blurryImageView)
        blurryImageView.snp.makeConstraints { (snpMake) in
            snpMake.left.equalTo(0)
            snpMake.top.equalTo(headViewHeight - ScreenWidth + 64)
            snpMake.width.equalTo(ScreenWidth)
            snpMake.height.equalTo(ScreenWidth)
        }
        //模糊效果
        let blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView.init(effect: blurEffect)
        blurView.frame.size = CGSize.init(width: ScreenWidth, height: ScreenWidth)
        blurryImageView.addSubview(blurView)
        
        view.addSubview(radioTableView)
        radioTableView.snp.makeConstraints { (snpMake) in
            snpMake.left.bottom.right.equalTo(view)
            snpMake.top.equalTo(view).offset(64)
        }
        radioTableView.delegate = self
        radioTableView.dataSource = self
        headView.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: headViewHeight)
        radioTableView.tableHeaderView = headView
        headView.backgroundColor = UIColor.clear
        radioTableView.backgroundColor = UIColor.clear
        radioTableView.separatorStyle = .none
        radioTableView.register(AlbumTableCell.self, forCellReuseIdentifier: detailIndentifier)
        radioTableView.register(LiveProgramCell.self, forCellReuseIdentifier: programIndentifier)
        headView.addSubview(smallImageView)
        let orginX = (ScreenWidth - 100) / 2
        smallImageView.snp.makeConstraints { (snpMake) in
            snpMake.top.equalTo(headViewHeight - 140)
            snpMake.left.equalTo(orginX)
            snpMake.width.height.equalTo(100)
        }
        smallImageView.layer.borderWidth = 1
        smallImageView.layer.borderColor = UIColor.white.cgColor
        
        headView.addSubview(playButton)
        playButton.snp.makeConstraints { (snpMake) in
            snpMake.top.left.bottom.right.equalTo(smallImageView)
        }
        playButton.setImage(UIImage.init(named: "playerview_btn_play"), for: .normal)
        playButton.setImage(UIImage.init(named: "playerview_btn_pause"), for: .selected)
        playButton.addTarget(self, action: #selector(playRadioProgram(button:)), for: .touchUpInside)
        playButton.imageEdgeInsets = UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15)
        if AudioModel.sharedInstanced.radioPlayer?.moviePlayer.playbackState == MPMoviePlaybackState.playing && AudioModel.sharedInstanced.currentSongInfo?.playUrl ==  radioInfo?.playUrl{
            playButton.isSelected = true
        }else{
            playButton.isSelected = false
        }
        
        //navBar
        navbarView.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 64)
        navbarView.backgroundColor = UIColor.clear
        self.view.addSubview(navbarView)
        
        let backButton:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 64, height: 64))
        backButton.backgroundColor = UIColor.clear
        backButton.setImage(UIImage.init(named: "back_9x16"), for: UIControlState.normal)
        backButton.setImage(UIImage.init(named: "back_9x16"), for: UIControlState.selected)
        backButton.addTarget(self, action: #selector(self.backToPreVC), for: UIControlEvents.touchUpInside)
        backButton.imageEdgeInsets = UIEdgeInsets.init(top: 20, left: 5, bottom: 0, right: 0)
        navbarView.addSubview(backButton)
        
        titleLabel.frame = CGRect.init(x: backButton.frame.size.width, y: 20, width: navbarView.frame.size.width - backButton.frame.size.width * 2, height: navbarView.frame.size.height - 20)
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        navbarView.addSubview(titleLabel)
        
        titleLabel.text = radioInfo?.name
        
    }
    func backToPreVC() {
        _  = self.navigationController?.popViewController(animated: true)
    }

    func loadData() {
        if radioInfo?.cover != nil {
            blurryImageView.sd_setImage(with: URL.init(string: (radioInfo?.cover)!))
            smallImageView.sd_setImage(with: URL.init(string: (radioInfo?.cover)!))
        }
        weak var weakSelf:RadioDetailViewController? = self

        guard radioInfo?.radioId != nil else {
            return
        }        
        FindRequest.sharedInstanced.radioProgramDetailDataLoad(userId: "\((radioInfo?.radioId)!)") { (radio:RadioDetailData?, succeed:Bool, error:Error?) in
            weakSelf?.dataSources =  radio?.cons
            if weakSelf?.dataSources != nil{
                
                let radio:RadioListDeatil = RadioListDeatil()
                radio.type = 9009090
                weakSelf?.dataSources?.insert(radio, at: 0)
            }
            
            weakSelf?.radioTableView.reloadData()
        }
        

        
    }

    func playRadioProgram(button:UIButton) {
        if button.isSelected {
            AudioModel.sharedInstanced.pauseAudio()
            button.isSelected = false
        }else{
            button.isSelected = true
            if AudioModel.sharedInstanced.currentSongInfo?.playUrl ==  radioInfo?.playUrl{
                AudioModel.sharedInstanced.resumePlayer()
            }else{
                //播放
                let songInfo = SongInfo()
                songInfo.logoUrl = radioInfo?.cover
                songInfo.playUrl = radioInfo?.playUrl
                songInfo.name    = radioInfo?.name
                songInfo.isLive  = true
                songInfo.index   = 0
                AudioModel.sharedInstanced.livePlaying(info: songInfo, showInView: self.view)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        //注意下面一条语句将系统的手势会屏弊掉,如果没有下面的一条语句拖动边缘是可以返回去的
        navigationController?.setNavigationBarHidden(true, animated: true)
        //依然保持手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension RadioDetailViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if dataSources == nil {
            return 0
        }
        return (dataSources?.count)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let detail:RadioListDeatil = dataSources![section]
        if detail.type ==  9009090{
            return 1
        }
        return (detail.sectionDetails?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detail:RadioListDeatil = dataSources![indexPath.section]
        if detail.type ==  9009090{
            let cell:LiveProgramCell = tableView.dequeueReusableCell(withIdentifier: programIndentifier, for: indexPath) as! LiveProgramCell
            if radioInfo != nil {
                cell.loadData(info: radioInfo!)
            }
            return cell
        }
        let cell:AlbumTableCell = tableView.dequeueReusableCell(withIdentifier: detailIndentifier, for: indexPath) as! AlbumTableCell
        cell.loadRadioDetailData(info: (detail.sectionDetails?[indexPath.row])!)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let orginY = headViewHeight - ScreenWidth - scrollView.contentOffset.y + 64
        if scrollView.contentOffset.y < headViewHeight - 64 {
            blurryImageView.frame = CGRect.init(x: 0, y: orginY, width: ScreenWidth, height: ScreenWidth)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let detail:RadioListDeatil = dataSources![indexPath.section]
        if detail.type ==  9009090{
            return 180
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let detail:RadioListDeatil = dataSources![section]
        if detail.type ==  9009090{
            return 0
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let detail:RadioListDeatil = dataSources![section]
        if detail.type ==  9009090{
            return UIView()
        }
        let headView:HeaderReusableView = HeaderReusableView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 40))
        headView.headerDelegate = self
        headView.section = section
        headView.loadDataWithInfo(info: detail)
        return headView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail:RadioListDeatil = dataSources![indexPath.section]
        let albumDe:SectionDetailsModel = detail.sectionDetails![indexPath.row] 
        let vc  = AlbumViewController()
        vc.albumPid = albumDe.resourceId!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func reusableViewClicked(section: Int) {
        let detail:RadioListDeatil = dataSources![section]
        let vc:MoreAlbumViewController = MoreAlbumViewController()
        let info:ProgramList = ProgramList()
        info.categoryId = detail.id!
        info.name = detail.name
        info.objectId =  detail.id!
        vc.programInfo = info
        self.navigationController?.pushViewController(MoreAlbumViewController(), animated: true)
    }
    func headerReusableViewClicked(info: ProgramList) {
        
    }
    

}

