//
//  WgButtonExtension.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/30.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit
import ObjectiveC

class WgButtonExtension: NSObject {

}

extension UIButton{
    struct WgButtonKey {
        static var identifier = "identifier"
    }
    
    var tthh: String?{
        get{
            return objc_getAssociatedObject(self, &WgButtonKey.identifier) as? String
        }
        set{
            objc_setAssociatedObject(self, &WgButtonKey.identifier, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
}




