//
//  SwipeableCell.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/15.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class SwipeableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func buildCell(model: SwipeableCellModel) {
        self.imageView?.image = UIImage(named: model.imageName)
        self.textLabel?.text = model.titleName
        self.textLabel?.textAlignment = .center
    }
}


struct SwipeableCellModel {
    var imageName: String
    var titleName: String
}
