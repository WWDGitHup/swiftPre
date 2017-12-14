//
//  MoreAlbumViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import MJRefresh

class MoreAlbumViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var programInfo:ProgramList?
    fileprivate var recommendCollectionView:UICollectionView?
    fileprivate var collectionLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    fileprivate let moreAlbumListIndentifier = "moreAlbumListIndentifier"
    fileprivate var alarmList:MoreAlbumList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        self.loadData()
        
        self.setupUI()
        
    }
    
    
    func setupUI() -> () {
        collectionLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        collectionLayout.minimumLineSpacing = 0//左右揭开间隔
        collectionLayout.minimumInteritemSpacing = 5.0//上下间隔
        
        print(self.view.bounds.size.height)
        self.recommendCollectionView = UICollectionView.init(frame:CGRect.init(x: 0, y: 0, width: ScreenWidth, height:ScreenHeight) , collectionViewLayout: collectionLayout)
        self.recommendCollectionView?.delegate = self
        self.recommendCollectionView?.dataSource = self;
        self.view.addSubview(self.recommendCollectionView!)
        self.recommendCollectionView?.alwaysBounceVertical = true //不够一面可以滚动
        self.recommendCollectionView?.backgroundColor = UIColor.init(red: 250 / 255.0, green: 250 / 255.0, blue: 250 / 255.0, alpha: 1.0)
        self.recommendCollectionView?.register(MoreCollectionCell.self, forCellWithReuseIdentifier: moreAlbumListIndentifier)
        
        self.recommendCollectionView?.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.headerRefreshData))

    }
    //下拉刷新
    func headerRefreshData() {
        self.loadData()
    }
    
    func loadData(){
        
        if programInfo != nil{
            weak var weakSelf:MoreAlbumViewController? = self
            FindRequest.sharedInstanced.MoreAlbumLoad(pageIndex: "0", atypeId: String(programInfo!.categoryId)) {(albumList:MoreAlbumList?,succeed:Bool,error:Error?) in
                if succeed{
                    weakSelf?.alarmList = albumList
                    weakSelf?.recommendCollectionView?.mj_header.endRefreshing()
                    weakSelf?.recommendCollectionView?.reloadData()
                    weakSelf?.title  = weakSelf?.programInfo?.name
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        //注意下面一条语句将系统的手势会屏弊掉,如果没有下面的一条语句拖动边缘是可以返回去的
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension MoreAlbumViewController{
    //返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:MoreCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: moreAlbumListIndentifier, for: indexPath) as! MoreCollectionCell
        let albumDe:AlbumDetail = (self.alarmList?.con![indexPath.row])! as! AlbumDetail
        cell.loadData(info: albumDe, indexPath: indexPath)
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if self.alarmList != nil && self.alarmList?.con != nil{
          return (self.alarmList?.con?.count)!
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.widthForUI(margin:5, marginCount: 8, count: 3) , height: self.widthForUI(margin:5, marginCount: 8, count: 3) + CGFloat(50))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let albumDe:AlbumDetail = (self.alarmList?.con![indexPath.row])! as! AlbumDetail
        let vc  = AlbumViewController()
        vc.albumPid = albumDe.albumId
        vc.provideCode = albumDe.providerId
        self.navigationController?.pushViewController(vc, animated: true)

        
    }

}
