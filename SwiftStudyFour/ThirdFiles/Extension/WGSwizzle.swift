//
//  WGSwizzle.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/17.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func wgswizzle() {
        //创建消息对象
        let originalSelector = #selector(viewDidLoad)
        let swizzleSelector = #selector(wg_viewDidLoad)
        //创建方法
        let oriMethod = class_getInstanceMethod(self, originalSelector)
        let swiMethod = class_getInstanceMethod(self, swizzleSelector)
        print("wgswizzle中oriMethod方法:\(String(describing: oriMethod))")
        print("wgswizzle中swiMethod方法:\(String(describing: swiMethod))")
        method_exchangeImplementations(oriMethod!, swiMethod!)
    }
    
    @objc fileprivate func wg_viewDidLoad() {
        print("用户点击进入:\(String(describing: NSStringFromClass(type(of: self)).components(separatedBy: ".").last!))页面")
        wg_viewDidLoad()
    }
}


