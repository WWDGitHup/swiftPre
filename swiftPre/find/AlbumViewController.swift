//
//  AlbumViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/23.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import MJRefresh

class AlbumViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate{

    var blurryImageView:UIImageView = UIImageView()
    var headView:UIView = UIView()
    var smallImageView:UIImageView = UIImageView()
    var collectionButton:UIButton = UIButton()
    var totalTableView:UITableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
    let titleArray:Array<String> = ["歌曲列表","专辑信息"]
    var albumInfo:AlbumInfo = AlbumInfo()
    var navLineImageView:UIImageView?
    
    var provideCode:Int?
    
    var dataArray:Array<SongInfo> = Array()
    
    var navbarView:UIView = UIView()
    var titleLabel:UILabel = UILabel()
    
    
    
    public var albumPid:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //创建UI
        setupUI()
        
        self.view.backgroundColor = UIColor.white
        
        
        self.automaticallyAdjustsScrollViewInsets = true
        
        navLineImageView = self.findHairlineImageViewUnder(view: (self.navigationController?.navigationBar)!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //注意下面一条语句将系统的手势会屏弊掉,如果没有下面的一条语句拖动边缘是可以返回去的
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //依然保持手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        super.viewWillAppear(animated)
        
        self.loadData(pageString: "0")
    }

    override func viewWillDisappear(_ animated: Bool) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:  创建UI
    func setupUI(){
        //背景图
        blurryImageView.frame = CGRect.init(x: 0, y: 220 - ScreenWidth  + 64 , width: ScreenWidth, height: ScreenWidth)
        blurryImageView.backgroundColor = UIColor.purple
        self.view.addSubview(blurryImageView)
        //模糊效果
        let blurEffect = UIBlurEffect.init(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView.init(effect: blurEffect)
        blurView.frame.size = CGSize.init(width: blurryImageView.frame.size.width, height: blurryImageView.frame.size.height)
        blurryImageView.addSubview(blurView)
        
        
        headView.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 220)
        
        smallImageView.frame = CGRect.init(x: (headView.frame.size.width - 80) / 2, y: headView.frame.size.height - 120, width: 80, height: 80)
        
        smallImageView.layer.borderWidth = 1
        smallImageView.layer.borderColor = UIColor.white.cgColor
        headView.addSubview(smallImageView)
        
        collectionButton.frame = CGRect.init(x: smallImageView.frame.origin.x, y: smallImageView.frame.origin.y + smallImageView.frame.size.height + 10, width: 80, height: 18)
        
        collectionButton.setTitle("收藏", for: UIControlState.normal)
        collectionButton.layer.borderWidth = 1
        collectionButton.layer.borderColor = UIColor.white.cgColor
        collectionButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        headView.addSubview(collectionButton)
        
        
        totalTableView.frame = CGRect.init(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight)
        totalTableView.delegate = self
        totalTableView.dataSource = self
        totalTableView.tableHeaderView = headView
        totalTableView.backgroundColor = UIColor.clear
        totalTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(totalTableView)
        
        totalTableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(self.mjRefreshFooterLoadData))
        
        
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
        
        titleLabel.frame = CGRect.init(x: 64, y: 20, width: ScreenWidth - 64 * 2, height: 44);
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        navbarView.addSubview(titleLabel)
        
        
    }
    func backToPreVC() {
      _  = self.navigationController?.popViewController(animated: true)
    }
    
    func mjRefreshFooterLoadData() {
        self.loadData(pageString: String(self.albumInfo.currentPage + 1))
    }
    func mjRefreshHeaderLoadData() {
        self.dataArray.removeAll()
        self.loadData(pageString:"0")
    }
    
    func loadData(pageString:String){
        
        weak var weakSelf:AlbumViewController? = self
        
        if self.provideCode == nil {
            self.provideCode = 3010
        }
        FindRequest.sharedInstanced.loadAlbumList(pageIndex: pageString, pid:String(self.albumPid), providerCode: "\(self.provideCode!)")
        FindRequest.sharedInstanced.albumSongDataFinshed = {(info:AlbumInfo?,succeed:Bool,error:Error?) -> () in
            if succeed {
                if info != nil {
                    weakSelf?.albumInfo = info!
                    DispatchQueue.main.async {
                        
                        weakSelf?.totalTableView.mj_footer.endRefreshing()
                    }
                    DispatchQueue.global().async {
                        guard info?.con != nil else{
                            return
                        }
                        guard (info?.con?.count)! > 0 else{
                            return
                        }
                        let  newSong:SongInfo = (info?.con?.first)! as! SongInfo
                        for oldSongInfo in (weakSelf?.dataArray)! {
                            if oldSongInfo.playUrl == newSong.playUrl {
                                return
                            }
                        }
                        for song in (info?.con)!{
                            weakSelf?.dataArray.append(song as! SongInfo)
                        }
                            
                        DispatchQueue.main.async {
                            weakSelf?.totalTableView.reloadData()
                        }
                    }
                    if info?.logoUrl != nil {
                        weakSelf?.smallImageView.sd_setImage(with: URL.init(string: (info?.logoUrl)!))
                        weakSelf?.blurryImageView.sd_setImage(with: URL.init(string: (info?.logoUrl)!))
                    }
                    weakSelf?.titleLabel.text = info?.columnName
                }
            }
        }
    }
}


extension AlbumViewController{
    
    func findHairlineImageViewUnder(view:UIView) -> UIImageView? {
        
        if view.isKind(of: UIImageView.self) && view.bounds.size.height <= 1.0{
            
            return view as? UIImageView
        }
        
        for subView:UIView in view.subviews {
            let imageView:UIImageView? = self.findHairlineImageViewUnder(view: subView)
            if (imageView != nil) {
                return imageView!
            }
        }
        return nil
    }
}

//MARK:   tableView delegate
extension AlbumViewController{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AlbumTableCell = AlbumTableCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "AlbumTableCell")
        let songInfo:SongInfo = self.dataArray[indexPath.row]
        
        cell.loadData(info: songInfo)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let head = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 45))
        head.backgroundColor = UIColor.white
        for title in titleArray
        {
            let index = titleArray.index(of: title)
            let originX = index! * (Int(tableView.frame.size.width) / Int(titleArray.count))
            let button:UIButton = UIButton.init(frame: CGRect.init(x: originX, y: 10, width: (Int(tableView.frame.size.width) / Int(titleArray.count)), height: 35))
            button.setTitle(title, for: UIControlState.normal)
            button.setTitle(title, for: UIControlState.selected)
            button.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
            button.setTitleColor(UIColor.init(colorLiteralRed: 49 / 255.0, green: 155/255.0, blue: 1.0, alpha: 1.0), for: UIControlState.selected)
            button.addTarget(self, action: #selector(self.buttonClick(button:)), for: UIControlEvents.touchUpInside)
            button.tag = index! + 3000
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            head.addSubview(button)
            if index! == 0 {
                button.isEnabled = true
            }
        }
        
        return head
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(scrollView.contentOffset.y);
        
        if scrollView.contentOffset.y < 220 - 64 {
            blurryImageView.frame = CGRect.init(x: 0, y: 220 - ScreenWidth - scrollView.contentOffset.y + 64, width: ScreenWidth, height: ScreenWidth)
        }
 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AudioModel.sharedInstanced.playAudioList(songList:self.dataArray, index: indexPath.row)
        self.navigationController?.pushViewController(SongPlayerViewController(), animated: true)
    }
    
    func buttonClick(button:UIButton)  {
        print(button.tag)
        
    }
    
}




