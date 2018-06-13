//
//  SecondViewModel.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/6.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class SecondViewModel: NSObject {
    var secondModel: SecondModel!
    var colorr: UIColor?
    override init() {
        super.init()
        secondModel = SecondModel()
    }
    
    func requestDatata() {
        secondModel.requestData()
        colorr = secondModel.color
        NotificationCenter.default.post(name: NSNotification.Name.init(kTextViewUpdateUI), object: nil)
    }
}

class SecondModel: NSObject {
    var color: UIColor?
    func requestData() {
        //生成随机色
        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let colorRun = UIColor.init(red:red, green:green, blue:blue , alpha: 1)
        color = colorRun
    }
}
