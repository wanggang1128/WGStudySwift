//
//  UIRefreashOnMainthreadTest.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/17.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit

class UIRefreashOnMainthreadTest: WGMainViewController {

    let btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBtnView()
    }
    
    func setBtnView() {
        view.backgroundColor = UIColor.white
        btn.backgroundColor = UIColor.yellow
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.frame = CGRect(x: 100, y: 100, width: 200, height: 40)
        btn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        btn.tthh = "123456"
        print("tthh的值为:",btn.tthh!)
        view.addSubview(btn)
    }
    
    @objc func btnClicked() {
        // 分离出一条子线程,自动启动线程,但无法获得线程对象
        Thread.detachNewThreadSelector(#selector(uitest), toTarget: self, with: nil)
    }
    
    @objc func uitest() {
        let thread = Thread.current
        print("当前线程:\(String(describing: thread.name))--\(thread)")
        print("主线程:\(String(describing: Thread.main.name))--\(Thread.main)")
        btn.setTitle("子线程刷新", for: .normal)
        
        //在子线程中新建一个按钮
        let newBtn = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 40))
        newBtn.setTitle("子线程创建的按钮", for: .normal)
        newBtn.backgroundColor = UIColor.blue
        view.addSubview(newBtn)
        
        Thread.sleep(forTimeInterval: 5)
    }
}
