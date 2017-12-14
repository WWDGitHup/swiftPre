//
//  LiveProgramCell.swift
//  swiftPre
//
//  Created by apple on 2017/1/9.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit

class LiveProgramCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

    
    let indentifierCell = "RadioDetailCell"
    
    var dataSources:Array<AnchorpersonModel>?
    
    
    lazy var radioCollectionView:UICollectionView = {
        
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: self.radioFlowLyout)
        return collectionView
    }()
    
    /*
     重复调用，Lazy 属性的代码块只会调用一次,lazy修饰的是一个存储属性，而存放的是闭包,我想内部，应该进行了优化
     */
    lazy var radioFlowLyout:VTScrollFlowLayout = {
        let flowLyout = VTScrollFlowLayout()
        flowLyout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return flowLyout
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print(frame.size.height)
        
        self.radioCollectionView.dataSource = self
        self.radioCollectionView.delegate =  self
        self.radioCollectionView.register(RadioDetailCell.self, forCellWithReuseIdentifier: indentifierCell)
        self.addSubview(self.radioCollectionView)
        self.radioCollectionView.backgroundColor = UIColor.init(red: 242 / 255.0, green: 242 / 255.0, blue: 242 / 255.0, alpha: 1.0)
        self.radioCollectionView.showsVerticalScrollIndicator = false
        self.radioCollectionView.showsHorizontalScrollIndicator = false
        self.radioCollectionView.snp.makeConstraints { (snpMake) in
            snpMake.top.left.right.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadData(info:RadioInfoModel) {
        
        let array:Array<String> = ["http://i2.hdslb.com/video/63/63f122b740a6df2b61581f81fe070a04.jpg","http://dealer2.autoimg.cn/dealerdfs/g19/M10/37/4A/620x0_1_q87_autohomedealer__wKjBxFawFGmAXY3GAACeT_BdGUQ658.jpg","http://img.heibaimanhua.com/wp-content/uploads/2015/06/20150628_558f641a9ff94.jpg","http://img.heibaimanhua.com/wp-content/uploads/2015/06/20150628_558f6416e76fa.jpg","http://i.dimg.cc/cd/4e/46/bf/9d/13/1d/cc/fd/7d/2e/e4/e3/a7/f9/d2.jpg","http://img4.duitang.com/uploads/item/201411/27/20141127190808_ihCAe.png","http://imgsrc.baidu.com/forum/w%3D580/sign=7d13be9bb44543a9f51bfac42e178a7b/7240dc3f8794a4c2b31487440df41bd5ac6e39f6.jpg","http://pic.makepolo.net/news/allimg/20161228/1482938545040660.jpg","http://imgsrc.baidu.com/forum/w%3D580/sign=cc16b211261f95caa6f592bef9177fc5/96f50eb30f2442a7822f4acad243ad4bd01302db.jpg","http://imgsrc.baidu.com/forum/w=580/sign=376c7c2ebb315c6043956be7bdb0cbe6/a291effc1e178a826e93af9bf103738da877e892.jpg","http://img6.cache.netease.com/photo/0036/2016-12-14/C890B5KR5H1I0036.jpg","http://c.hiphotos.baidu.com/zhidao/pic/item/b3b7d0a20cf431ada19674734d36acaf2edd9837.jpg","http://imgsrc.baidu.com/forum/w%3D580/sign=9d25ee444310b912bfc1f6f6f3fcfcb5/68f3cfbf6c81800a49ec20f1b53533fa838b476b.jpg","http://cdn.duitang.com/uploads/item/201511/01/20151101162047_YPJnz.jpeg","http://imgmini.eastday.com/mobile/20160406134202_b7147f4688369c4d9bbfbafe360f739b_4.jpeg","http://imgsrc.baidu.com/forum/w%3D580/sign=bb9df7c2249759ee4a5060c382fa434e/3eaaa28b87d6277f2d48a1f72a381f30eb24fcd7.jpg","http://imgsrc.baidu.com/forum/w%3D580/sign=371e7d62878ba61edfeec827713597cc/4a75b78f8c5494ee763474b128f5e0fe98257eab.jpg","http://pic.qiushibaike.com/system/pictures/11802/118021405/medium/app118021405.jpg"]
        
        dataSources = info.con
        guard dataSources != nil else {
            return
        }
        for index in 0..<(dataSources?.count)! {
            
            let ancho = dataSources?[index]
            if array.count > index {
                ancho?.logo = array[index]
            }else{
                ancho?.logo = array[0]
            }

        }

        self.radioCollectionView.reloadData()

        guard (dataSources?.count)! > 0 else {
            return
        }
        
        
        for index in 0..<dataSources!.count {
            
            let ancho = dataSources![index]
            let startString = ancho.startTime
            let sSecond = startString?.getSecondUserTime(time: startString)
            let enSecond = ancho.endTime?.getSecondUserTime(time: ancho.endTime)
            let nowSecond = startString?.getNowSecond()
            
            if nowSecond! > sSecond! && nowSecond! < enSecond! {
                
                let indexPath:IndexPath = IndexPath.init(row: index, section: 0)
                DispatchQueue.main.async {
                    self.radioCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
                }
                
                break
            }
        }
        
        
        

    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK: collection delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.dataSources == nil {
            return 0
        }
        return self.dataSources!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:RadioDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: indentifierCell, for: indexPath) as! RadioDetailCell
        cell.loadDataImage(info: (self.dataSources?[indexPath.row])!)
        return cell
    }

}
