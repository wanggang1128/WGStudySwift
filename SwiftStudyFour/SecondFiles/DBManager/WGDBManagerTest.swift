//
//  WGDBManagerTest.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/28.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class WGDBManagerTest: NSObject {
    
    func dbManagerTest() {
        //新建表
        WGDBManager.createDBTable(tableName: .userTable, fileName: "one")
        WGDBManager.createDBTable(tableName: .friendTable, fileName: "one")
        
        //查询某用户数据库所有表名
        _ = WGDBManager.findAllTableName(fileName: "one")
        
        //查询某表中所有表字段
        _ = WGDBManager.findTableFeilds(tableName: .userTable, fileName: "one")
        _ = WGDBManager.findTableFeilds(tableName: .friendTable, fileName: "one")
        
        //删除指定表
        WGDBManager.deleteDBTables(tableNames: [.userTable, .friendTable], fileName: "one")
        
        //删除某用户数据库
        WGDBManager.deleteDB(fileName: "one")
        
        //保存数据
        let dic = ["userName":"zhang", "passWord" : "123321"]
        let dic01 = ["userName" : "friends01", "nick": "nicheng01", "avater" : "touxiang01"]
        WGDBManager.saveData(tableName: .userTable, contentDic: dic, fileName: "one")
        WGDBManager.saveData(tableName: .friendTable, contentDic: dic01, fileName: "one")
        
        //更新数据
        WGDBManager.updataData(tableName: .userTable, contentDic: dic, fileName: "one")
        WGDBManager.updataData(tableName: .friendTable, contentDic: dic01, fileName: "one")
        
        //删除数据
        WGDBManager.deleteData(tableName: .userTable, condition: "userName = '\((dic["userName"])!)'", fileName: "one")
        
        //查询数据
        _ = WGDBManager.getData(tableName: .userTable, condition: "", fileName: "one")
        _ = WGDBManager.getData(tableName: .friendTable, condition: "", fileName: "one")
    }
}
