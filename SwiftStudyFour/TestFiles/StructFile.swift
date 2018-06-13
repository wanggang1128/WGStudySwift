//
//  StructFile.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/4.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class StructFile: NSObject {

}

struct Rectangle {
    var with: Double
    var height: Double
    var area: Double {
        return self.with * self.height
    }
    init(with: Double, height: Double) {
        self.with = with
        self.height = height
    }
}
