//
//  ViewControllerCellModel.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/7.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class ViewControllerCellModel: NSObject {
    var img: String
    var titleStr: String
    
    init(image: String, title: String) {
        self.img = image
        self.titleStr = title
    }
    
    static func baseCellArr() -> [ViewControllerCellModel] {
        var modelArr = [ViewControllerCellModel]()
        for i in 1 ... 20 {
            let model = ViewControllerCellModel(image: String(format: "%i", i), title: String(format: "第%i个", i))
             modelArr.append(model)
        }
        return modelArr
    }
}
