//
//  SecondViewController.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/6.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var secondViewModel: SecondViewModel {
        let viewModel = SecondViewModel()
        return viewModel
    }
    
    var secondView: SecondView {
        let view = SecondView(secondM: secondViewModel)
        view.frame = CGRect(x: 0, y: 64, width: WgWith, height: WgHeight-64)
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        self.view.addSubview(secondView)
    }

}
