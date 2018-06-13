//
//  PromptView.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/5.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit

protocol PSelectDeledate {
    func didClicked(isSec: Bool)
}

class PromptView: UIView {
    
    private var viewModel: PromptViewModel!
    var delegate: PSelectDeledate?
    
    private let mainView = UIView()
    private let imageView = UIImageView()
    private let titleMsgLab = UILabel()
    private let bottomView = UIView()
    private let closeBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewModel = PromptViewModel(model: PromptModel(pType: UserInfoManager.userInfoManagerShared.userStoreState))
        setBaseView()
        setBottomView()
    }
    
    func setBaseView() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.addSubview(mainView)
        mainView.backgroundColor = UIColor.white
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 5
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(64)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(mainView.snp.width).multipliedBy(1.1)
        }
        
        mainView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        imageView.image = UIImage(named: "shop.png")
        
        mainView.addSubview(titleMsgLab)
        titleMsgLab.backgroundColor = UIColor.clear
        titleMsgLab.textAlignment = .center
        titleMsgLab.numberOfLines = 0
        titleMsgLab.adjustsFontSizeToFitWidth = true
        titleMsgLab.minimumScaleFactor = 0.7
        titleMsgLab.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom)
//            make.left.right.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        mainView.addSubview(bottomView)
        bottomView.backgroundColor = UIColor.clear
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(titleMsgLab.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        self.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(mainView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(55)
        }
        closeBtn.setBackgroundImage(#imageLiteral(resourceName: "deldete.png"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBtnClicked), for: .touchUpInside)
    }
    
    func setBottomView() {
        let ignoreBtn = UIButton()
        let sureBtn = UIButton()
        
        bottomView.addSubview(ignoreBtn)
        ignoreBtn.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        ignoreBtn.setTitle("忽略", for: .normal)
        ignoreBtn.setTitleColor(UIColor.gray, for: .normal)
        ignoreBtn.addTarget(self, action: #selector(ignoreBtnClicked), for: .touchUpInside)
        
        bottomView.addSubview(sureBtn)
        sureBtn.snp.makeConstraints { (make) in
            make.left.equalTo(ignoreBtn.snp.right)
            make.top.bottom.right.equalToSuperview()
        }
        sureBtn.setTitle("查看进度", for: .normal)
        sureBtn.setTitleColor(UIColor.red, for: .normal)
        sureBtn.addTarget(self, action: #selector(sureBtnClicked), for: .touchUpInside)
        
        titleMsgLab.text = viewModel.tMessage
    }
    
    @objc func ignoreBtnClicked() {
        print("点击了忽略")
        self.removeFromSuperview()
    }
    
    @objc func sureBtnClicked() {
        print("点击了查看进度")
        self.delegate?.didClicked(isSec: true)
        self.removeFromSuperview()
    }
    
    @objc func closeBtnClicked() {
        print("点击了❎")
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
