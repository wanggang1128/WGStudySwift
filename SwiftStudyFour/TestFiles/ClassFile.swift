//
//  ClassFile.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/4.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class ClassFile: NSObject {

}

class Student: Person {
    var stuDeledate: Person?
    var firstName: String
    var lastName: String
    var school: String
    var fullName: String {
        return self.firstName + "." + self.lastName
    }
    func description() -> String {
        return "firstName:\(firstName) lastName:\(lastName) school:\(school)"
    }
    init(fir: String, last: String, school: String) {
        self.firstName = fir
        self.lastName = last
        self.school = school
    }
}

class Worker: Person {
    var firstName: String
    var lastName: String
    var factory: String
    var fullName: String {
        return self.firstName + "." + self.lastName
    }
    func description() -> String {
        return "firstName:\(firstName) lastName:\(lastName) factory:\(factory)"
    }
    init(fir: String, last: String, factory: String) {
        self.firstName = fir
        self.lastName = last
        self.factory = factory
    }
}











