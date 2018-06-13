//
//  StoreProgressViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/5.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit

class StoreProgressViewController: WGMainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellow
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backAction)), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
}
