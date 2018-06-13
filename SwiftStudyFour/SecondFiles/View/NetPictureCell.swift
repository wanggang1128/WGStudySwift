//
//  NetPictureCell.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/8.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit

class NetPictureCell: UITableViewCell {

    var nickName = UILabel()
    var detailMsg = UILabel()
    var headImage = UIImageView()
    var titleLab = UILabel()
    var contentImage = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        //头像  【重点】必须在创建第一块控件的时候约束：contentView
        contentView.addSubview(headImage)
        headImage.backgroundColor = UIColor.clear
        headImage.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(5)
            make.left.equalToSuperview().offset(5)
            make.width.height.equalTo(44)
        }
        
        //昵称
        contentView.addSubview(nickName)
        nickName.backgroundColor = UIColor.clear
        nickName.textColor = UIColor.black
        nickName.font = UIFont.systemFont(ofSize: 18)
        nickName.textAlignment = .left
        nickName.snp.makeConstraints { (make) in
            make.left.equalTo(headImage.snp.right).offset(5)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(24)
        }
        
        //附加信息
        contentView.addSubview(detailMsg)
        detailMsg.textColor = UIColor.lightGray
        detailMsg.font = UIFont.systemFont(ofSize: 12)
        detailMsg.textAlignment = .left
        detailMsg.backgroundColor = UIColor.clear
        detailMsg.numberOfLines = 0
        detailMsg.lineBreakMode = .byCharWrapping
        detailMsg.snp.makeConstraints { (make) in
            make.left.equalTo(headImage.snp.right).offset(5)
            make.right.equalToSuperview()
            make.top.equalTo(nickName.snp.bottom)
            make.height.equalTo(20)
        }
        
        //标题
        contentView.addSubview(titleLab)
        titleLab.backgroundColor = UIColor.clear
        titleLab.textColor = UIColor.black
        titleLab.font = UIFont.systemFont(ofSize: 20)
        titleLab.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview()
            make.top.equalTo(headImage.snp.bottom).offset(5)
            make.height.equalTo(24)
        }
        
        //图片   【重点】必须在创建最后一块控件的时候约束：contentView
        contentView.addSubview(contentImage)
        contentImage.backgroundColor = UIColor.clear
        contentImage.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(contentImage.snp.width)
            make.bottom.equalTo(contentView).offset(-5)
        }
    }
    
    func setUI(model: NetPictureModel) {
        //头像
        headImage.setImageWith(URL(string: "\(HeadImage)\(model.headerUrl)")!, placeholderImage: UIImage(named: "shop"))
        //图片
        contentImage.setImageWith(URL(string: "\(ImageHead)\(model.catalog)/\(model.issue)/\(model.headImageFilename)")!, placeholderImage: UIImage(named: "shop"))
        self.nickName.text = model.nickName
        self.detailMsg.text = "生日：\(model.birthday) 资质：\(model.bwh) 身高：\(model.height)"
        self.titleLab.text = model.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}













