//
//  FunnyViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/21.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import TangramKit

class FunnyViewController: BaseFindViewController,UITableViewDelegate,UITableViewDataSource{

    fileprivate var funnyTableView:UITableView?
    let indentiferVideo = "FunnyVideoCell"
    
    fileprivate var dataSource:Array<FunnyRecommendModel> = Array()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.gray
        
        self.setupUI()
    }
    
    func setupUI() {
        funnyTableView = UITableView.init(frame:CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64 - 44 - 50), style: UITableViewStyle.plain)
        funnyTableView?.dataSource = self
        funnyTableView?.delegate = self
        self.view.addSubview(funnyTableView!)
        funnyTableView?.register(FunnyVideoCell.self, forCellReuseIdentifier: indentiferVideo)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
   
    func loadData() {
        weak var weakSelf:FunnyViewController? = self
        FunnyRequest().requestFunnyVideoList { (funnyModel:FunnyHomeDataModel?, succeed:Bool, error: Error?) in
            guard let model = funnyModel else{
                return
            }
            if model.data != nil{
                weakSelf?.dataSource = (model.data)!
                weakSelf?.funnyTableView?.reloadData()
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func scrollToCurrentViewContriller() {
        super.scrollToCurrentViewContriller()
        
        //点击
         self.loadData()
    }

}

extension FunnyViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FunnyVideoCell = tableView.dequeueReusableCell(withIdentifier: indentiferVideo, for: indexPath) as! FunnyVideoCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let funnyModel:FunnyRecommendModel = self.dataSource[indexPath.row]
        cell.indexPath = indexPath
        cell.loadVideoData(model:funnyModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let funnyModel:FunnyRecommendModel = self.dataSource[indexPath.row]
        return calculateCellHeight(model: funnyModel)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //滚动停止后暂停播放
        
        let array = funnyTableView?.indexPathsForVisibleRows
        if array != nil {
            if (array?.count)! > 0 {
                var stopAll:Bool = true
                for indexp:IndexPath in array! {
                    let funnyModel:FunnyRecommendModel = self.dataSource[indexp.row]
                    if funnyModel.group?.mp4_url == AVPlayerModel.sharedInstanced.currentPlayUrlString{
                        stopAll = false
                    }
                }
                if stopAll {
                    NotificationCenter.default.post(name: NSNotification.Name.init("PlayerWillFinishedNotication"), object: nil)
                    
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了0000")
    }
    func calculateCellHeight(model:FunnyRecommendModel) -> CGFloat {
        guard let groupf = model.group else {
            return 0
        }
        
        let width = self.view.frame.width - 20
        var heightString = groupf.content?.getStringHeight(font: UIFont.systemFont(ofSize: 14), limitWidth: width)
        if groupf.content == nil {
            heightString = 0
        }
        if groupf.video_height != 0{
            let rate:CGFloat = CGFloat(groupf.video_width!) / CGFloat(groupf.video_height!)
            var imageHeight = width / rate
            if imageHeight > 350 {
                imageHeight = 350
            }
            if groupf.mp4_url == nil {
                imageHeight = 0
            }
            //无评论
            return CGFloat(100) + CGFloat(heightString!) + imageHeight
        }

        return CGFloat(80) + CGFloat(heightString!)
    }
    
}






