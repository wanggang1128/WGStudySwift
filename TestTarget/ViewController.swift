//
//  ViewController.swift
//  TestTarget
//
//  Created by hanlei on 2017/12/7.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let obc = TestTargetObj()
        obc.initWithname("桥接成功")
        print("桥接文件实验:\(obc.name)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

