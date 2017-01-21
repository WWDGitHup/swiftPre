//
//  LiveTableViewCell.swift
//  swiftPre
//
//  Created by apple on 2017/1/4.
//  Copyright © 2017年 victor. All rights reserved.
//

import UIKit

class LiveTableViewCell: UITableViewCell {

    
    var headImageView:UIImageView = UIImageView()
    var titleLabel:UILabel = UILabel()
    var liveLabel:UILabel = UILabel()
    var anchorLabel:UILabel = UILabel()
    var vtBuytton:VTButton = VTButton.init(frame: CGRect.zero)
    var onlineLabel:UILabel = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(headImageView)
        self.addSubview(titleLabel)
        self.addSubview(liveLabel)
        self.addSubview(anchorLabel)
        self.addSubview(onlineLabel)

        headImageView.snp.makeConstraints { (snpMake) in
            snpMake.top.equalTo(self).offset(15)
            snpMake.left.equalTo(self).offset(15)
            snpMake.width.height.equalTo(60)
        }
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UIColor.init(red: 53 / 255.0, green: 53 / 255.0, blue: 53 / 255.0, alpha: 1.0)
        titleLabel.snp.makeConstraints { (snpMake) in
            snpMake.top.equalTo(headImageView).offset(3)
            snpMake.left.equalTo(headImageView.snp.right).offset(10)
            snpMake.height.equalTo(17)
            snpMake.right.equalTo(self).offset(-30)
        }
        
        liveLabel.font = UIFont.systemFont(ofSize: 11)
        liveLabel.textColor = UIColor.init(red: 153 / 255.0, green: 153 / 255.0, blue: 153 / 255.0, alpha: 1.0)
        liveLabel.snp.makeConstraints { (snpMake) in
            snpMake.top.equalTo(titleLabel.snp.bottom).offset(2)
            snpMake.left.equalTo(titleLabel)
            snpMake.height.equalTo(14)
            snpMake.right.equalTo(self).offset(-30)
        }
        
        anchorLabel.font = UIFont.systemFont(ofSize: 10)
        anchorLabel.textColor = UIColor.init(red: 189 / 255.0, green: 189 / 255.0, blue: 189 / 255.0, alpha: 1.0)
        anchorLabel.snp.makeConstraints { (snpMake) in
            snpMake.bottom.equalTo(headImageView.snp.bottom).offset( -2)
            snpMake.left.equalTo(titleLabel)
            snpMake.height.equalTo(14)
            snpMake.width.equalTo(100)
        }
        
       
        onlineLabel.font = UIFont.systemFont(ofSize: 10)
        onlineLabel.textColor = UIColor.init(red: 189 / 255.0, green: 189 / 255.0, blue: 189 / 255.0, alpha: 1.0)
        onlineLabel.textAlignment = NSTextAlignment.right
        onlineLabel.snp.makeConstraints { (snpMake) in
            snpMake.bottom.equalTo(headImageView.snp.bottom).offset( -2)
            snpMake.left.equalTo(titleLabel)
            snpMake.height.equalTo(14)
            snpMake.right.equalTo(self).offset(-30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadDataLive(radio:RadioInfoModel) {
        
        if radio.cover != nil {
            headImageView.sd_setImage(with: URL.init(string: radio.cover!))
        }
        
        titleLabel.text = radio.title
        if radio.clicks != nil {
            onlineLabel.text = "\(radio.clicks!)人收听"
        }
        if radio.con != nil {
            guard (radio.con?.count)! > 0 else {
                return
            }
            for ancho in radio.con! {
                let startString = ancho.startTime
                let sSecond = self.getSecondUserTime(time: startString)
                let enSecond = self.getSecondUserTime(time: ancho.endTime)
                let nowSecond = self.getNowSecond()
                
                if nowSecond > sSecond && nowSecond < enSecond {
                    
                    guard ancho.name != nil else {
                        return
                    }
                    guard ancho.anchorperson != nil else {
                        return
                    }
                    liveLabel.text = "正在直播：\(ancho.name!)"
                    anchorLabel.text = "主持人：\(ancho.anchorperson!)"
                    break
                }
            }
        }
    }
    
    func getSecondUserTime(time:String?) -> Int {
        guard time != nil else {
            return 0
        }
        let array = time?.components(separatedBy: ":")
        guard (array?.count)! == 2 || (array?.count)! > 2 else {
            return 0
        }
        let hour = array?[0]
        let min = array?[1]
        if hour != nil && min != nil{
            let second = Int(hour!)! * 60 + Int(min!)!
            return second
        }
        return 0
    }
    
    func getNowSecond() -> Int {
        let date = Date()
        let timeFm = DateFormatter()
        timeFm.dateFormat = "HH:mm"
        let strTime = timeFm.string(from: date)
        return self.getSecondUserTime(time: strTime)
    }
    
}
