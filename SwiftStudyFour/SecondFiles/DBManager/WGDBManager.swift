//
//  WGDBManager.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/25.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

enum DBTableName: String {
    case userTable = "userTable"
    case friendTable = "friendTable"
}

class WGDBManager: NSObject {
    
    static var defaultName = "FMDB"
    private static var dbDirPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
    
    //获取数据库路径
    static func getDBPath(fileName: String = defaultName) -> (Bool, String) {
        let isExit = FileManager.default.fileExists(atPath: dbDirPath!)
        //判断本地此文件存不存在，不存在则新建
        if !isExit {
            do {
                try FileManager.default.createDirectory(atPath:  dbDirPath!, withIntermediateDirectories: true, attributes: nil)
            }catch let error as NSError{
                print("创建\(String(describing: dbDirPath!))失败:\(String(describing: error.localizedFailureReason))")
                return (false, "")
            }
        }
        let dbPath = dbDirPath?.appendingFormat("/%@_%@", fileName,"DB.sqlite")
        print("数据库路径:\(String(describing: dbPath!))")
        return (true, dbPath!)
    }
    
    //MARK: - 数据库操作
    //查找本地数据库没有则初始化
    static func createOrFindDB(fileName: String = defaultName) -> FMDatabase? {
        let dbPath = WGDBManager.getDBPath(fileName: fileName).1
        return  FMDatabase(path: dbPath)
    }
    
    //删除数据库
    static func deleteDB(fileName: String = defaultName) {
        let dbPath = WGDBManager.getDBPath(fileName: fileName).1
        let isExit = WGDBManager.getDBPath(fileName: fileName).0
        if isExit {
            do {
                try FileManager.default.removeItem(atPath: dbPath)
                print("删除数据库:\(fileName)_DB.sqlite成功")
            } catch let error as NSError {
                print("删除数据库:\(fileName)_DB.sqlite失败:\(String(describing: error.localizedFailureReason))")
            }
        } else {
            print("本地没有\(fileName)数据库，无需删除")
        }
    }
    
    //MARK: - 数据库中表操作
    //创建表，一个用户一个数据库,一个数据库可以有多个表
    static func createDBTable(tableName: DBTableName, fileName: String = defaultName) {
        if tableName.rawValue.count < 1 {
            return
        }
        guard WGDBManager.getDBPath(fileName: fileName).0 else {
            print("数据库路径不存在")
            return
        }
        let dbpath = WGDBManager.getDBPath(fileName: fileName).1
        let dbQueue = FMDatabaseQueue(path: dbpath)
        dbQueue?.inDatabase({ (database) in
            if !database.tableExists(tableName.rawValue) {
                switch tableName {
                case .userTable:
                    if database.executeUpdate(String(format: "create table if not exists %@(userName text PRIMARY KEY, passWord text)", tableName.rawValue), withArgumentsIn: []) {
                        print("创建表\(tableName.rawValue)成功")
                    }
                case .friendTable:
                    if database.executeUpdate(String(format: "create table if not exists %@(userName text PRIMARY KEY, nick text, avater text)", tableName.rawValue), withArgumentsIn: []) {
                        print("创建表\(tableName.rawValue)成功")
                    }
                }
            }else {
                print("表\(tableName.rawValue)已经存在")
            }
        })
    }
    
    /*
        获取某个用户数据库中所有的表名
        采用手动打开数据库的方式
    */
    static func findAllTableName(fileName: String = defaultName) -> [String]? {
        var tableNames = [String]()
        let db = createOrFindDB(fileName: fileName)
        print("数据库地址\(String(describing: db))")
        if (db?.open())! {
            do {
                let set = try db?.executeQuery("SELECT name FROM sqlite_master WHERE type = 'table' ORDER BY name", values: nil)
                while (set?.next())! {
                    tableNames.append((set?.string(forColumn: "name"))!)
                }
            } catch let error as NSError {
                print("读取列表失败:\(String(describing: error.localizedFailureReason))")
            }
        } else {
            print("数据库打开失败")
        }
        db?.close()
        print("获取\(fileName)的数据库中所有表名:\(tableNames)")
        return tableNames
    }
    
    /**
     删除指定数组内的表
     采用FMDBQueue---inTransaction的方式，更新等操作用该方式最好
     */
    static func deleteDBTables(tableNames: [DBTableName], fileName: String = defaultName) {
        if tableNames.count < 1 {
            return
        }
        let dbpath = WGDBManager.getDBPath(fileName: fileName).1
        let dbQueue = FMDatabaseQueue(path: dbpath)
        dbQueue?.inTransaction({ (database, roolback) in
            for name in tableNames {
                do {
                   try database.executeUpdate("DROP TABLE IF EXISTS \(name.rawValue)", values: nil)
                    print("删除表\(name.rawValue)成功！")
                }catch let err as NSError {
                    print("删除表\(name.rawValue)失败:\(String(describing: err.localizedFailureReason))")
                    roolback.pointee = true
                    /*事务回滚
                     oc: roolback = yes
                     swift: roolback.pointee = true
                     */
                    return
                }
            }
        })
    }
    
    //MARK: - 表内部数据操作
    /**
     获得指定表的字段名
     采用FMDBQueue---inDatabase的方式，查询数据最好使用该方式
     */
    static func findTableFeilds(tableName: DBTableName, fileName: String = defaultName) -> [String]? {
        if tableName.rawValue.count < 1 {
            return nil
        }
        let dbPath = WGDBManager.getDBPath(fileName: fileName).1
        let dbQueue = FMDatabaseQueue(path: dbPath)
        
        var tables = [String]()
        dbQueue?.inDatabase({ (database) in
            do {
                let set = try database.executeQuery("PRAGMA table_info(\(tableName.rawValue))", values: nil)
                while set.next() {
                    tables.append(set.string(forColumn: "name")!)
                }
            } catch let error as NSError {
                print("查询\(tableName.rawValue)字段名失败：\(String(describing: error.localizedFailureReason))")
            }
        })
        print("\(tableName.rawValue)所有字段名:\(tables)")
        return tables
    }
    
    //新增数据
    static func saveData(tableName: DBTableName, contentDic: Dictionary<String, String>, fileName: String = defaultName) {
        if tableName.rawValue.count < 1 {
            return
        }
        let dbPath = WGDBManager.getDBPath(fileName: fileName).1
        let dbQueue = FMDatabaseQueue(path: dbPath)
        dbQueue?.inTransaction({ (db, roolback) in
            switch tableName {
            case .userTable:
                let res = db.executeUpdate("INSERT INTO \(tableName.rawValue) (userName, passWord) VALUES (:userName, :passWord)", withParameterDictionary: contentDic)
                res ? print("\(fileName)数据库在表\(tableName.rawValue)插入\(contentDic)成功！") : print("\(fileName)数据库在表\(tableName.rawValue)插入\(contentDic)失败！")
            case .friendTable:
                let res = db.executeUpdate("INSERT INTO \(tableName.rawValue) (userName, nick, avater) VALUES (:userName, :nick, :avater)", withParameterDictionary: contentDic)
                res ? print("\(fileName)数据库在表\(tableName.rawValue)插入\(contentDic)成功！") : print("\(fileName)数据库在表\(tableName.rawValue)插入\(contentDic)失败！")
            }
        })
    }
    
    //删除数据
    static func deleteData(tableName: DBTableName, condition: String, fileName: String = defaultName) {
        if tableName.rawValue.count < 1 {
            return
        }
        let dbPath = WGDBManager.getDBPath(fileName: fileName).1
        let dbQueue = FMDatabaseQueue(path: dbPath)
        dbQueue?.inTransaction({ (db, roolback) in
            let res = db.executeUpdate("DELETE FROM \(tableName.rawValue) WHERE \(condition)", withArgumentsIn: [])
            res ? print("\(fileName)数据库在表\(tableName.rawValue)删除\(condition)成功！") : print("\(fileName)数据库在表\(tableName.rawValue)删除\(condition)失败！")
        })
    }
    
    //修改数据
    static func updataData(tableName: DBTableName, contentDic: Dictionary<String, String>, fileName: String = defaultName) {
        if tableName.rawValue.count < 1 {
            return
        }
        let dbPath = WGDBManager.getDBPath(fileName: fileName).1
        let dbQueue = FMDatabaseQueue(path: dbPath)
        dbQueue?.inTransaction({ (db, roolback) in
            switch tableName {
            case .userTable:
                let res = db.executeUpdate("UPDATE \(tableName.rawValue) SET passWord = (:passWord) WHERE userName = (:userName)", withParameterDictionary: contentDic)
                res ? print("\(fileName)数据库在表\(tableName.rawValue)修改\(contentDic)成功！") : print("\(fileName)数据库在表\(tableName.rawValue)修改\(contentDic)失败！")
            case .friendTable:
                let res = db.executeUpdate("UPDATE \(tableName.rawValue) SET nick = (:nick), avater = (:avater) WHERE userName = (:userName)", withParameterDictionary: contentDic)
                res ? print("\(fileName)数据库在表\(tableName.rawValue)修改\(contentDic)成功！") : print("\(fileName)数据库在表\(tableName.rawValue)修改\(contentDic)失败！")
            }
        })
    }
    
    //查询数据
    static func getData(tableName: DBTableName, condition: String, fileName: String) -> [Dictionary<String, String>]? {
        if tableName.rawValue.count < 1 {
            return nil
        }
        var result = [Dictionary<String, String>]()
        let dbPath = WGDBManager.getDBPath(fileName: fileName).1
        let dbQueue = FMDatabaseQueue(path: dbPath)
        dbQueue?.inDatabase({ (db) in
            let set = condition.count < 1 ? db.executeQuery("SELECT * FROM \(tableName.rawValue)", withParameterDictionary: nil) : db.executeQuery("SELECT * FROM \(tableName.rawValue) WHERE \(condition)", withParameterDictionary: nil)
            guard (set != nil) else {
                return
            }
            switch tableName {
            case .userTable:
                while (set?.next())! {
                    var dic = [String : String]()
                    dic.updateValue((set?.string(forColumn: "userName"))!, forKey: "userName")
                    dic.updateValue((set?.string(forColumn: "passWord"))!, forKey: "passWord")
                    result.append(dic)
                }
            case .friendTable:
                while (set?.next())! {
                    var dic = [String : String]()
                    dic.updateValue((set?.string(forColumn: "userName"))!, forKey: "userName")
                    dic.updateValue((set?.string(forColumn: "nick"))!, forKey: "nick")
                    dic.updateValue((set?.string(forColumn: "avater"))!, forKey: "avater")
                    result.append(dic)
                }
            }
        })
        print("查询数据结果:\(result)")
        return result
    }
}
