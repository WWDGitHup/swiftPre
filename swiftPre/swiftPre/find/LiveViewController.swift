//
//  LiveViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/21.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class LiveViewController: BaseFindViewController ,UITableViewDataSource,UITableViewDelegate{

    let liveTableViewCellIndentifier = "liveTableViewCellIndentifier"
    
    var dataSource:Array<RadioInfoModel> = Array()
    
    var liveTableView:UITableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
    override func viewDidLoad() {
        super.viewDidLoad()

        liveTableView.delegate = self
        liveTableView.dataSource = self
        liveTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        liveTableView.register(LiveTableViewCell.self, forCellReuseIdentifier: liveTableViewCellIndentifier)
        self.view.addSubview(liveTableView)
        liveTableView.snp.makeConstraints { (snpMake) in
            snpMake.top.left.right.equalTo(self.view)
            snpMake.bottom.equalTo(self.view).offset(-44)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func scrollToCurrentViewContriller() {
        super.scrollToCurrentViewContriller()
        
        //点击
        weak var weakSelf:LiveViewController? = self
        FindRequest.sharedInstanced.radioStattionDataLoad { (radio:RadioData?, succeed:Bool, error:Error?) in
            
            if radio?.con != nil{
                if (radio?.con?.count)! > 0    {
                    guard (radio?.con![0]) != nil else{
                        return
                    }
                    let live:LiveListModel = (radio?.con![0])!
                    weakSelf?.dataSource = live.liveList!
                    weakSelf?.liveTableView.reloadData()
                }
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("funny view show")
    }
    
    
    //MARK: uitableview delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LiveTableViewCell = tableView.dequeueReusableCell(withIdentifier: liveTableViewCellIndentifier, for: indexPath) as! LiveTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let info:RadioInfoModel = dataSource[indexPath.row]
        cell.loadDataLive(radio: info)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info:RadioInfoModel = dataSource[indexPath.row]
        let vc:RadioDetailViewController = RadioDetailViewController()
        vc.title = info.name
        vc.radioInfo = info
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
