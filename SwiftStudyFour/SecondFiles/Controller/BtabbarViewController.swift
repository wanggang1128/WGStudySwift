//
//  BtabbarViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/21.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class BtabbarViewController: WGMainViewController {
    
    let imageV = UIImageView(frame: CGRect(x: 0, y: 0, width: WgWith, height: WgHeight))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
        UIView.animate(withDuration: 1) {
            self.imageV.alpha = 1
            self.imageV.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        imageV.alpha = 0
        imageV.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setBaseView() {
        view.backgroundColor = UIColor.white
        imageV.alpha = 0
        imageV.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        imageV.image = UIImage(named: "Explore")
        view.addSubview(imageV)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}










