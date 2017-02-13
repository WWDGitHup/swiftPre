//
//  SubscribeViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/16.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import MJRefresh
class SubscribeViewController: UIViewController ,MiaoShowRequestDelegate,UITableViewDelegate,UITableViewDataSource{

    let miaoShowHotRequest:MiaoShowRequest = MiaoShowRequest()
    var dataSource:[VideoLiveInfo]?
    let liveTableView:UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
    let reduesIndentigier = "MiaoShowHotTableViewCell"
    var currentIndex = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        liveTableView.delegate = self
        liveTableView.dataSource = self
        liveTableView.separatorStyle = .none
        liveTableView.register(MiaoShowHotTableViewCell.self, forCellReuseIdentifier: reduesIndentigier)
        view.addSubview(liveTableView)
        liveTableView.snp.makeConstraints { (snpMake) in
            snpMake.left.right.top.bottom.equalTo(self.view)
        }
        
        liveTableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.dataSource == nil {
            miaoShowHotRequest.getMiaoShowHotList(pageIndex: 1)
            miaoShowHotRequest.delegate = self;
        }
    }
    

    func loadMoreData() {
        currentIndex = currentIndex + 1
        miaoShowHotRequest.getMiaoShowHotList(pageIndex: currentIndex)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension SubscribeViewController{
    //MARK: MiaoShowRequestDelegate
    func getMiaoShowHotListReturnBackFaild(error: Error) {
        print(error)
    }
    
    func getMiaoShowHotListReturnBack(pageIndex: Int, list: LiveListInfo) {
        
        if self.dataSource == nil {
            self.dataSource = list.list
            self.liveTableView.reloadData()
            return
        }
        if self.currentIndex == 1 {
            self.dataSource?.removeAll()
            self.dataSource = list.list
            self.liveTableView.reloadData()
            return
        }
        DispatchQueue.global().async {
            guard list.list != nil else{
                return
            }
            guard (list.list?.count)! > 0 else{
                return
            }
            let  newVideo:VideoLiveInfo = (list.list?.first)!
            for liveList in self.dataSource! {
                if liveList.flv == newVideo.flv {
                    return
                }
            }
            for video in list.list!{
                self.dataSource?.append(video)
            }
            
            DispatchQueue.main.async {
                self.liveTableView.reloadData()
                self.liveTableView.mj_footer.endRefreshing()
            }
        }
        
    }
    
    //MARK: tableview delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MiaoShowHotTableViewCell = tableView.dequeueReusableCell(withIdentifier: reduesIndentigier, for: indexPath) as! MiaoShowHotTableViewCell
        cell.selectionStyle = .none
        cell.loadCellData(info: (dataSource?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource == nil {
            return 0
        }
        return (dataSource?.count)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LivePlayerViewController()
        vc.currentIndex = indexPath.row
        vc.dataSource = dataSource
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85 + ScreenWidth
    }
    
    
}



