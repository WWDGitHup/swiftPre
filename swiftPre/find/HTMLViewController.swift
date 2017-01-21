//
//  HTMLViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/29.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class HTMLViewController: UIViewController {

    let webView:UIWebView = UIWebView()
    var htmlUrl:String = "https:www.baidu.com"
    
    
    
    init(html:String,title:String?) {

        //制定构造器 与 遍历构造器  http://www.tuicool.com/articles/uUbUJjy
        super.init(nibName: nil, bundle: nil)
        self.htmlUrl = html
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.green
        
        webView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.addSubview(webView)
        
        //点击
        webView.loadRequest(URLRequest.init(url: URL.init(string: self.htmlUrl)!))
        
        
//        let afterSecond:TimeInterval = 10.0
        
//        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + afterSecond) {
//            if self.weakSelf != nil{
//                
//                print("内存没有被释放")
//            }else{
//                print("内存已经被释放")
//            }
//            
//            
//        }
        
        
        
        
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
