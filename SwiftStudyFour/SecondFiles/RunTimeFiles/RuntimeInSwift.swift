//
//  RuntimeInSwift.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/29.
//  Copyright © 2018年 wg. All rights reserved.
//

import Foundation

class TextASwiftClass{
    @objc dynamic var abool: Bool = true
    @objc dynamic var aint:Int = 0
    @objc dynamic var afloat: Float = 123.45
    @objc dynamic var adouble: Double = 1234.567
    @objc dynamic var astring: String = "abc"
    @objc dynamic var aobject: AnyObject? = nil
    
    @objc dynamic func textReturnVoidWithId(aid: UIView){
        
    }
}

class TextSwiftClass: UIViewController {
    var abool: Bool = true
    var aint:Int = 0
    var afloat: Float = 123.45
    var adouble: Double = 1234.567
    var astring: String = "abc"
    var aobject: AnyObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func WG_viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("WG_viewDidDisappear")
    }
    
    func textReturnVoidWithId(aid: UIView){
        
    }
    
    func textReturnVoidWithBool(aBool: Bool, aInt: Int, aFloat: Float, aDouble: Double, aString: String, aObject: AnyObject){
        
    }
    
    func textReturnTuple(aBool: Bool, aInt: Int, aFloat: Float) -> (Bool, Int, Float) {
        return (aBool, aInt, aFloat)
    }
    
    func textReturnVoidWithCharecter(aCharecter: Character){
        
    }
    
    func tableView(tableView: UITableView, numbersOfSection section: Int) -> Int{
        return 20
    }
}

class RuntimeInSwift {
    static func showClsRuntime(cls: AnyClass){
        print("开始打印方法列表")
        //获取类中方法列表
        var methodCount: UInt32 = 0
        let methodList = class_copyMethodList(cls, &methodCount)
        //遍历方法列表
        if let methodList = methodList {
            for index in 0..<numericCast(methodCount) {
                let method: Method = methodList[index]
                print(String(utf8String: method_getTypeEncoding(method)!)!)
                print(String(utf8String: method_copyReturnType(method))!)
                print(String(_sel: method_getName(method)))
            }
        }
        print("结束打印方法列表")
        
        print("开始打印属性列表")
        //获取类中属性列表
        var propertyCount: UInt32 = 0
        let propertyList = class_copyPropertyList(cls, &propertyCount)
        if let propertyList = propertyList {
            for index in 0..<numericCast(propertyCount){
                let property: objc_property_t = propertyList[index]
                print(String(utf8String: property_getName(property))!)
                print(String(utf8String: property_getAttributes(property)!)!)
            }
        }
        print("结束打印属性列表")
    }
}










