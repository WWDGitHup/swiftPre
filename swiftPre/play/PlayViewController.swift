//
//  PlayViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/16.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import HandyJSON
import MJExtension
import SwiftyJSON

class PlayViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    //数据源数组
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var objectAnchor:RutuObject?
    let indentifier  = "AnchorCollectionViewCell"
    let layout = UICollectionViewFlowLayout()
    var collectionView:UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //使用collectionView 布局
        
        self.view.backgroundColor = UIColor.white
        
        //加载数据
        loadData()
        //加载UI
        setUI()
        
        
        
        
        
        
    }

    func setUI() {
        //滚动方向
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.itemSize = CGSize.init(width: 100, height: 120)
        layout.minimumLineSpacing = 5//左右揭开间隔
        layout.minimumInteritemSpacing = 10.0//上下间隔
        layout.headerReferenceSize = CGSize.init(width: 10, height: 10)
        layout.footerReferenceSize = CGSize.init(width: 10, height: 10)
       
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: height - 40), collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        self.view.addSubview(collectionView!)
        
        //z注册cell
        collectionView?.register(AnchorCollectionViewCell.self, forCellWithReuseIdentifier: indentifier)
        
    }
    
    func loadData() -> (){

        HttpResquest.sharedInstanced.get("http://mobile.ximalaya.com/mobile/discovery/v1/anchor/recommend?device=iPhone&version=5.4.27", parameters: nil, progress: {(Progress) -> () in
            
        }, success: {(dataTask:URLSessionDataTask,dataSource:Any?) -> () in
                //确定有值   强制解析
            if dataSource != nil {
                print(dataSource!)
                
                let dict = dataSource as! Dictionary<String,AnyObject>
                var rutuModel:RutuObject = RutuObject()
                rutuModel = rutuModel.analyJsonRutu(dictory: dict)
                print(rutuModel)
                self.objectAnchor = rutuModel
                self.collectionView?.reloadData()
                
            }
            
            
        }, failure: {(dataTask, error) -> Void in
            
            print(error)
        })
 
        
    }
    
    //MARK  collectionview delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let anchor:AnchorInfo = (self.objectAnchor?.famous?[section])!
        
        return (anchor.list?.count)!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if self.objectAnchor != nil{
            return (self.objectAnchor?.famous?.count)!

        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:AnchorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: indentifier, for: indexPath) as! AnchorCollectionViewCell
        
        let anchor:AnchorInfo = (self.objectAnchor?.famous?[indexPath.section])!
        let info:AnchorList = anchor.list![indexPath.row]
        cell.setCollectionViewCellData(anchor: info)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchor:AnchorInfo = (self.objectAnchor?.famous?[indexPath.section])!
        let info:AnchorList = anchor.list![indexPath.row]
        print(info)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
