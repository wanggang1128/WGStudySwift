//
//  ExtensionFile.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/4.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class ExtensionFile: NSObject {

}

extension Int {
    var errorMessage: String {
        var message = ""
        switch self {
        case (-1):
            message = "没有数据"
        case (-2):
            message = "格式错误"
        case (-3):
            message = "长度不够"
        case (-4):
            message = "非法字符"
        default:
            message = "未知错误"
        }
        return message
    }
}

extension Double {
    static let interestRate: Double = 0.066
    func caculateRateOne() ->Double {
        return self * .interestRate
    }
    mutating func caculateRateTwo() {
        self = self * .interestRate
    }
    static func caculateRateThree(amount: Double) -> Double {
        return amount * .interestRate
    }
}

extension Rectangle{
    init(length: Double) {
        self.init(with: length, height: length)
    }
}

extension String {
    func sub(index: Int) -> String{
        if index > self.count{
            return ""
        }
        var c: String = ""
        var i: Int = 0
        for character in self {
            if i == index {
                c = String(character)
                break
            }
            i += 1
        }
        return c
    }
}






