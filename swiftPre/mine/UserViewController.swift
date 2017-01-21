//
//  UserViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/16.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import SnapKit

class UserViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    let userTableViewCellIndentifier = "UserTableViewCellIndentifier"
    
    let headView:UIView! = UIView()
    let userTableView:UITableView! = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
    var dataSource = Array<Dictionary<String,String>>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.green
        
        
        self.setupUI()
        loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func setupUI() {
        userTableView.dataSource = self
        userTableView.delegate = self
        self.view.addSubview(userTableView)
        
        userTableView.register(UserTableViewCell.self, forCellReuseIdentifier: userTableViewCellIndentifier)
        userTableView.snp.makeConstraints { (snpMake) in
            snpMake.top.equalTo(self.view)
            snpMake.left.equalTo(self.view)
            snpMake.right.equalTo(self.view)
            snpMake.bottom.equalTo(self.view)
        }
        userTableView.separatorStyle = .none
        
        headView.frame = CGRect.init(x: 0, y: 0, width: userTableView.frame.size.width, height: 160)
        headView.backgroundColor = UIColor.init(red: 242 / 255.0, green: 242 / 255.0, blue: 242 / 255.0, alpha: 1.0)
        let headButton = UIButton()
        headView.addSubview(headButton)
        headButton.layer.cornerRadius = 40
        headButton.clipsToBounds = true
        headButton.snp.makeConstraints { (make) in
            make.center.equalTo(headView)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        headButton.sd_setImage(with: URL.init(string: "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1919983060,2833771867&fm=58"), for: UIControlState.normal)
        headButton.sd_setImage(with: URL.init(string: "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1919983060,2833771867&fm=58"), for: UIControlState.selected)
        let headTitle = UILabel()
        headView.addSubview(headTitle)
        headTitle.snp.makeConstraints { (snpMake) in
            snpMake.left.right.equalTo(headView)
            snpMake.top.equalTo(headButton.snp.bottom).offset(5)
            snpMake.height.equalTo(20)
        }
        headTitle.textAlignment = NSTextAlignment.center
        headTitle.textColor = UIColor.init(red: 53 / 255.0, green: 53 / 255.0, blue: 53 / 255.0, alpha: 1.0)
        headTitle.font = UIFont.systemFont(ofSize: 16)
        headTitle.text = "东东"
        
        userTableView.tableHeaderView = headView
        
    }
    
    
    func loadData() {
        dataSource = [["title":"我的消息","image":"Events_Comment.png"], ["title":"我的账户","image":"common_comment.jpg"], ["title":"我关注的主播","image":"DJRoom_skimNum.png"], ["title":"我的下载","image":"WIFI_searchimage_2.png"], ["title":"我的活动","image":"Events_Comment.png"], ["title":"我的收藏","image":"WIFI_searchimage_2"], ["title":"我的收听历史","image":"WIFI_searchimage_2"], ["title":"我的优惠券","image":"Couponds_myCoupond.png"], ["title":"账号绑定","image":"Events_Comment.png"], ["title":"设置","image":"SignIn_SecureLock.png"]]
        
        self.userTableView.reloadData()
        
    }
    
    
    //MARK:   tableview delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:UserTableViewCell = tableView.dequeueReusableCell(withIdentifier: userTableViewCellIndentifier, for: indexPath) as! UserTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        let dic = self.dataSource[indexPath.row]
        cell.loadUserData(dictory: dic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

}









