//
//  MainViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/16.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    fileprivate let titles:[String] = ["发现","订阅","收听","下载","我的"]
    fileprivate let selectedImage:[String] = ["tabHomeHL","tabFocusHL","tabLivingHL","tabVideoHL","tabMineHL"]
    
    fileprivate let normalImage:[String] = ["tabHome","tabFocus","tabLiving","tabVideo","tabMine"]

    fileprivate let vcs: [UIViewController]? = [FindViewController(),SubscribeViewController(),PlayViewController(),DownloadViewController(),UserViewController()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //发现，下载 ，收听，  订阅 ，我的
        
        for item  in 0..<titles.count {
            let controller = vcs?[item]
            controller?.tabBarItem.image = UIImage.init(named: normalImage[item])
            controller?.tabBarItem.selectedImage = UIImage.init(named: selectedImage[item])
            let navVC = MainNavgationViewController.init(rootViewController: controller!)
            controller?.navigationItem.title = titles[item]
            controller?.tabBarItem.title = titles[item]
            self.addChildViewController(navVC)
        }
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
