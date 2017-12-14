//
//  RecommendViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/21.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import MJRefresh

class RecommendViewController: BaseFindViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HeaderReusableViewDelegate {
    

    fileprivate var recommendCollectionView:UICollectionView?
    fileprivate var collectionLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    fileprivate var dataSources = Array<ProgramList>()
    fileprivate var bannerArray = Array<BannerInfo>()
    
    fileprivate let headCellIndentifier = "headCellIndentifier"
    fileprivate let anchorLoveCell = "anchorLoveCell"
    fileprivate let commondCell = "commondCell"
    fileprivate let anchoVdCell = "anchoVdCell"
    fileprivate let headCollectionCell = "headCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.loadData(mobile: nil)
        
        self.creatRecommenView()
        
        
    }
    override func scrollToCurrentViewContriller() {
        super.scrollToCurrentViewContriller()
        
        //点击
        
        print("点击了----")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


//MARK:  load data
extension RecommendViewController{

    func loadData(mobile:String?) -> () {
        

        if mobile != nil {
           FindRequest.sharedInstanced.loadRecommendData(mobile: mobile!)
        }else{
            FindRequest.sharedInstanced.loadRecommendData(mobile: nil)
        }
        
        weak var weakSelf:RecommendViewController? = self
        //闭包回调
        FindRequest.sharedInstanced.findLoadDataFinished = { (info:RecommendInfo?,succeed:Bool,error:Error?) -> () in
            
            if info != nil {
                print(info!)
                if info?.con != nil {
                    weakSelf?.dataSources = (info?.con!)! as! Array<ProgramList>
                    let pro:ProgramList = ProgramList()
                    weakSelf?.dataSources.insert(pro, at: 0)
                    
                }
                if info?.bannerList != nil {
                    weakSelf?.bannerArray = (info?.bannerList)! as! Array<BannerInfo>
                }
                
                weakSelf?.recommendCollectionView?.mj_header.endRefreshing()
                weakSelf?.recommendCollectionView?.reloadData()
            }
        }
    }
}


extension RecommendViewController{
    func creatRecommenView() -> () {
        //头部滚动试图

        collectionLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        collectionLayout.minimumLineSpacing = 0//左右揭开间隔
        collectionLayout.minimumInteritemSpacing = 5.0//上下间隔
        
        self.recommendCollectionView = UICollectionView.init(frame:CGRect.init(x: 0, y: 0, width: ScreenWidth, height:ScreenHeight - 150) , collectionViewLayout: collectionLayout)
        self.recommendCollectionView?.delegate = self
        self.recommendCollectionView?.dataSource = self;
        self.view.addSubview(self.recommendCollectionView!)
        self.recommendCollectionView?.backgroundColor = UIColor.init(red: 250 / 255.0, green: 250 / 255.0, blue: 250 / 255.0, alpha: 1.0)
        self.recommendCollectionView?.register(HeadScrollCell.self, forCellWithReuseIdentifier: headCellIndentifier)
        self.recommendCollectionView?.register(AnchorLoveCell.self, forCellWithReuseIdentifier: anchorLoveCell)
        self.recommendCollectionView?.register(CommonThreeCell.self, forCellWithReuseIdentifier: commondCell)
        self.recommendCollectionView?.register(AnchoVideoCell.self, forCellWithReuseIdentifier: anchoVdCell)
        self.recommendCollectionView?.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headCollectionCell)
        self.recommendCollectionView?.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(self.headerRefreshData))
        
    }
    
    func headerRefreshData()  {
        self.loadData(mobile:nil)
    }
    
    
}

//MARK: collectionview delegate
extension RecommendViewController{
    //返回cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 && indexPath.section == 0 {
            let cell:HeadScrollCell = collectionView.dequeueReusableCell(withReuseIdentifier: headCellIndentifier, for: indexPath) as! HeadScrollCell
            
            cell.loadData(array: self.bannerArray)
            return cell
        }else{
            let program:ProgramList = self.dataSources[indexPath.section]
            //拍砖行动
            if program.type == 10{
                let cell:AnchorLoveCell = collectionView.dequeueReusableCell(withReuseIdentifier: anchorLoveCell, for: indexPath) as! AnchorLoveCell
                
                cell.loadData(info: program)
                return cell
                
            }else if program.type == 8{
                let cell:AnchoVideoCell = collectionView.dequeueReusableCell(withReuseIdentifier: anchoVdCell, for: indexPath) as! AnchoVideoCell
                cell.loadData(program: program)
                return cell
                
            }
            
            if program.layout == 0 || program.layout == 3 {
                let detai:DetailList = program.detailList[indexPath.row]
                let cell:CommonThreeCell = collectionView.dequeueReusableCell(withReuseIdentifier: commondCell, for: indexPath) as! CommonThreeCell
                cell.loadDataSetFrame(info:detai, indexPath: indexPath, layout:program.layout)
                
                return cell
            }

            let cell:UICollectionViewCell = UICollectionViewCell.init()
            return cell
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            let program:ProgramList = self.dataSources[section]
            if program.type == 10 {
                return 1
            } else if program.type == 8 {
                return 1
            }
            if program.layout == 0 || program.layout == 3{
                return program.detailList.count
            }
            
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 && indexPath.section == 0 {

            return CGSize.init(width: ScreenWidth, height: 165)
        }else
        {
            let program:ProgramList = self.dataSources[indexPath.section]
            if program.type == 10{
                return CGSize.init(width: ScreenWidth, height: 130)
            } else if program.type == 8{
                return CGSize.init(width: ScreenWidth, height: 210)
            }
            
            if program.layout == 0 {
               
                return CGSize.init(width: self.widthForUI(margin:5, marginCount: 8, count: 3) , height: self.widthForUI(margin:5, marginCount: 8, count: 3) + CGFloat(50))
            }else if program.layout == 3{
                print("widthForUI---- \(self.widthForUI(margin:10, marginCount: 3, count: 2))")
                return CGSize.init(width: self.widthForUI(margin:10, marginCount: 6, count: 2) , height: self.widthForUI(margin:10, marginCount: 3, count: 2) * 3 / 5  + CGFloat(40))
                
            }
            
            return CGSize.init(width: 0, height: 0)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            let headView:HeaderReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headCollectionCell, for: indexPath) as! HeaderReusableView
            let program:ProgramList = self.dataSources[indexPath.section]
            headView.loadData(info: program)
            headView.headerDelegate = self
            headView.section = indexPath.section
            return headView
        }else{
            return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0 {
            return CGSize.init(width: 0, height: 0)
        }else{
            let program:ProgramList = self.dataSources[section]
            if program.layout == 0 || program.layout == 3 {
                return CGSize.init(width: self.view.frame.width, height: 40)
            }else{
                return CGSize.init(width: 0, height: 0)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section != 0 {
            let program:ProgramList = self.dataSources[indexPath.section]
            let detai:DetailList = program.detailList[indexPath.row]
            if program.type == 8 {
                if detai.linkUrl != nil{
                    self.navigationController?.pushViewController(HTMLViewController.init(html: detai.linkUrl!,title:detai.name), animated: true)
                }
            }else{
                let vc  = AlbumViewController()
                vc.albumPid = detai.albumId
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    //MARK: HeaderReusableViewDelegate
    func headerReusableViewClicked(info: ProgramList) {
        
        let vc:MoreAlbumViewController = MoreAlbumViewController()
        vc.programInfo = info
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func reusableViewClicked(section: Int) {
        
    }
    
}






