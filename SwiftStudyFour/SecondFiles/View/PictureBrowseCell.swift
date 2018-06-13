//
//  PictureBrowseCell.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/8.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

let ItemWidth = WgWith-40.0
let ItemHeight = WgHeight/3.0

class PictureBrowseCell: UICollectionViewCell {
    var imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: ItemWidth, height: ItemHeight))
    var titleLab = UILabel(frame: CGRect(x: 0, y: ItemHeight-50, width: ItemWidth, height: 20))
    var detailLab = UILabel(frame: CGRect(x: 0, y: ItemHeight-30, width: ItemWidth, height: 30))
    
    var dataModel: PictureBrowseModel? {
        didSet{
            updateUI()
        }
    }
    
    func updateUI() {
        imgView.image = UIImage(named: (dataModel?.img)!)
        titleLab.text = dataModel?.title
        detailLab.text = dataModel?.detailTitle
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5.0
        imgView.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLab.backgroundColor = .gray
        titleLab.textColor = .white
        titleLab.textAlignment = .center
        if #available(iOS 8.2, *) {
            titleLab.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 4))
        } else {
            titleLab.font = UIFont.systemFont(ofSize: 16)
        }
        
        detailLab.backgroundColor = .white
        detailLab.backgroundColor = .gray
        detailLab.textColor = .white
        detailLab.textAlignment = .center
        detailLab.numberOfLines = 0
        detailLab.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(imgView)
        contentView.addSubview(titleLab)
        contentView.addSubview(detailLab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
