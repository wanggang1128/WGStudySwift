//
//  ProtocolFile.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/4.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class ProtocolFile: NSObject {

}

protocol Person {
    var firstName: String {get}
    var lastName: String {get}
    var fullName: String {get}
    func description() ->String
}

//加上anyObject，只有类才可以遵守就该协议
protocol Aaa: AnyObject {
    var fir: String {get}
    var sec: String {get}
}

protocol Bbb {
    var bb: String {get}
}

//只有遵守了Bbb协议，才会实现默认方法
extension Aaa where Self: Bbb {
    var fir: String {
        return "fir"
    }
}

class One: Aaa {
    var fir: String = ""
    
    var sec: String = ""
}

class Two: Aaa, Bbb {
    var sec: String = ""
    
    var bb: String = ""
}

//可选类型的协议
@objc protocol ProDelegate {
    func text01()
    @objc optional func text02(name: String, type: Int)
}

class ProClass: NSObject {
    var delegate: ProDelegate?
    func backAction() {
        delegate?.text01()
        delegate?.text02!(name: "可选", type: 333)
    }
}







