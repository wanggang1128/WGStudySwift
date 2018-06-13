//
//  NoteManager.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/6.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class NoteManager: NSObject {
    private var dataList = [NoteModel]()
    
    func createData(model: NoteModel) {
        dataList.append(model)
    }
    
    func removeData(model: NoteModel) throws {
        guard let date = model.date else {
            throw ErrorType.NoData
        }
        for (index, value) in dataList.enumerated() where date == value.date {
            dataList.remove(at: index)
        }
    }
    
    func modefiedData(model: NoteModel) throws {
        guard let date = model.date else {
            throw ErrorType.NoData
        }
        for mod in dataList where date == mod.date {
            mod.content = model.content
        }
    }
    
    func findAll() throws -> [NoteModel] {
        guard dataList.count > 0 else {
            throw ErrorType.NoData
        }
        defer {
            print("111")
        }
        defer {
            print("222")
        }
        return dataList
    }
    
    func findByDate(model: NoteModel) throws -> NoteModel? {
        guard let date = model.date else {
            throw ErrorType.NoData
        }
        for mod in dataList where date == mod.date {
            return mod
        }
        return nil
    }
}
