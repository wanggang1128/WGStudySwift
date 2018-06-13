//
//  MultilevelMenuHeadView.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/22.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit
import SnapKit

class MultilevelMenuHeadView: UITableViewHeaderFooterView {
    
    var imageView = UIImageView()
    var title = UILabel()
    var detailTitle = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        imageView.contentMode = .center
        title.font = UIFont.systemFont(ofSize: 14)
        title.textAlignment = .left
        self.addSubview(imageView)
        self.addSubview(title)
        self.addSubview(detailTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
       
        imageView.frame = CGRect(x: 0, y: 0, width: frame.height, height: frame.height)
        title.frame = CGRect(x: frame.height, y: 0, width: frame.width-2*frame.height, height: frame.height)
        detailTitle.frame = CGRect(x: frame.width-frame.height, y: 0, width: frame.height, height: frame.height)
   
    }
    
    func setUI(provice: Province) {
        imageView.image = provice.isOpening ? UIImage(named: "向下") : UIImage(named: "向右")
        title.text = provice.name
        detailTitle.text = String(provice.citys.count) + "个市"
    }
}
