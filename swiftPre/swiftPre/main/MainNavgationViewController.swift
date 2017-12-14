//
//  MainNavgationViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/16.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit
import AVFoundation

class MainNavgationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.tintColor = UIColor.white
        //as : 转换类型
        self.navigationBar.titleTextAttributes = NSDictionary.init(objects: [UIColor.white,UIFont.boldSystemFont(ofSize: 18)], forKeys: [NSForegroundColorAttributeName as NSCopying,NSFontAttributeName as NSCopying]) as? [String : Any]

        //设置navgation 的背景颜色
        //去掉边界线
        self.navigationBar.shadowImage = nil

        
        UITabBar.appearance().tintColor = UIColor.init(colorLiteralRed: 49 / 255.0, green: 155/255.0, blue: 1.0, alpha: 1.0)
        UINavigationBar.appearance().barTintColor = UIColor.init(colorLiteralRed: 49 / 255.0, green: 155/255.0, blue: 1.0, alpha: 1.0)
        
        
        guard let systemGes = interactivePopGestureRecognizer else { return }
        guard let gesView = systemGes.view else { return }
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]

        guard let targetObjc = targets?.first else { return }
        guard let target = targetObjc.value(forKey: "target") else { return }
        let action = Selector(("handleNavigationTransition:"))
        let panGes = UIPanGestureRecognizer()
        panGes.addTarget(target, action: action)
        gesView.addGestureRecognizer(panGes)
        
        
    }
    
    //跳转界面时候隐藏tabbar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


