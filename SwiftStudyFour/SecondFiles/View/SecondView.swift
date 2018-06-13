//
//  SecondView.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/6.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit
let kTextViewUpdateUI = "kTextViewUpdateUI"

class SecondView: UIView {

    var btn: UIButton!
    var secondViewModel: SecondViewModel!
    init(secondM: SecondViewModel) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        secondViewModel = secondM
        setBaseView()
        bangdingVM()
        secondViewModel.requestDatata()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBaseView() {
        btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        btn.setTitle("改变", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.titleLabel?.textColor = UIColor.black
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(buttonDidClick), for: .touchUpInside)
        self.addSubview(btn)
//        self.backgroundColor = UIColor.cyan
    }
    
    func bangdingVM() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.init(kTextViewUpdateUI), object: nil, queue: OperationQueue.main) { [weak self] notify in
            guard let strongSelf = self else {
                return
            }
            strongSelf.backgroundColor = strongSelf.secondViewModel.colorr
        }
    }
    
    @objc func buttonDidClick() {
        secondViewModel.requestDatata()
    }
}
