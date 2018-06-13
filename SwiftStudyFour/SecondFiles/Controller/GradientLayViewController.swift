//
//  GradientLayViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/13.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class GradientLayViewController: WGMainViewController {

    let gradientLayer = GradientLayerView(frame: CGRect(x: 20, y: 200, width: WgWith-40, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
        self.view.addSubview(gradientLayer)
        
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (time) in
                self.gradientLayer.progress += 0.08
                if self.gradientLayer.progress >= 1 {
                    time.invalidate()
                }
            }
        } else {
//            Timer.scheduledTimer(timeInterval: 1, invocation: , repeats: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}















