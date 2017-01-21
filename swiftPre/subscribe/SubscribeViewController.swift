//
//  SubscribeViewController.swift
//  SwiftTest
//
//  Created by apple on 2016/12/16.
//  Copyright © 2016年 weidong. All rights reserved.
//

import UIKit

class SubscribeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.purple
        
        
        let button = VTButton.init(frame: CGRect.init(x: 100, y: 200, width: 80, height: 20))
        button.setTimageViewImage(image: UIImage.init(named: "DJRoom_skimNum.png")!)
        button.setTTitleLabelText(text: "1210人")
        button.setImageViewFrame(frame: CGRect.init(x: 5, y: 5, width: 20, height: 10))
        self.view.addSubview(button)
        
        
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
