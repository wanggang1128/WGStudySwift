//
//  CtabbarViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/21.
//  Copyright © 2017年 wg. All rights reserved.
//
//练习SnapKit的使用

import UIKit
import SnapKit

class CtabbarViewController: WGMainViewController {

    let testView = UIView()
    let testView02 = UIView()
    //保存约束
    var updateConstrant: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setBaseView() {
        view.backgroundColor = UIColor.white
        testFunc04()
    }
    
    //实现一个宽高为100，居于当前视图的中心的视图布局
    func testFunc01() {
        view.addSubview(testView)
        testView.backgroundColor = UIColor.brown
        testView.snp.makeConstraints { (make) in
            make.width.height.equalTo(200) //链式语法直接定义宽高
            make.center.equalToSuperview() //直接在父视图居中
        }
    }
    
    //View2位于View1内， view2位于View1的中心， 并且距离View的边距的距离都为20
    func testFunc02() {
        testFunc01()
        testView.addSubview(testView02)
        testView02.backgroundColor = UIColor.blue
        testView02.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
    }

    //布局一个视图view2， 让它的水平中心线小于等于另一个视图的左边
    func testFunc03() {
        testFunc01()
        testView02.backgroundColor = UIColor.yellow
        testView.addSubview(testView02)
        testView02.snp.makeConstraints { (make) in
            make.top.equalTo(testView.snp.bottom).offset(10)
            make.width.height.equalTo(100)
            make.centerX.lessThanOrEqualTo(testView.snp.leading)
        }
    }

    //我们可以通过保存某一个约束布局来更新相应的约束，或者保存一组约束布局到一个数组中更新约束
    func testFunc04() {
        testFunc01()
        testView02.backgroundColor = UIColor.yellow
        testView.addSubview(testView02)
        testView02.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            updateConstrant = make.top.left.equalTo(10).constraint
        }
        let btn = UIButton()
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.bottom.equalTo(testView.snp.top).offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        btn.setTitle("change", for: .normal)
        btn.backgroundColor = UIColor.cyan
        btn.addTarget(self, action: #selector(changeBtnClicked), for: .touchUpInside)
    }
    
    
    @objc func changeBtnClicked() {
        self.updateConstrant?.update(offset: 50)
    }
}









