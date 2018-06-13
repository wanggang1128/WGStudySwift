//
//  MultilevelModel.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/22.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class MultilevelModel: NSObject {
    
    func initData() -> [Province]{
        var provice = [Province]()
        let dic = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Province", ofType: "plist")!)
        dic?.enumerateKeysAndObjects({ (key, value, roolBack) in
            let values = value as! NSDictionary
            var citys = [City]()
            for newKey in values.allKeys {
                citys.append(City(name: newKey as! String, alias: values[newKey] as! String))
            }
            provice.append(Province(name: key as! String, citys: citys, isOpening: false))
        })
        return provice
    }
}

struct City {
    let name: String
    let alias: String
}

struct Province {
    let name: String
    let citys: [City]
    var isOpening: Bool
}
