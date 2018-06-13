//
//  NetPictureModel.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/8.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit

struct NetPictureModel {
    let nickName: String
    let height: String
    let weight: String
    let bwh: String
    let birthday: String
    let pictureCount: Int
    
    let headerUrl: String
    let headImageFilename: String
    let title: String
    let issue: Int
    let catalog: String
    let ID: Int
    
    static func AppendData(data: Any?) -> [NetPictureModel] {
        var result = [NetPictureModel]()
        let dic = data as! NSDictionary
        let dataList = dic["data"] as! NSDictionary
        let list = dataList["list"] as! NSArray
        
        for mm in list {
            let mmDic = mm as! NSDictionary
            let mmSource = mmDic["source"] as! NSDictionary
            let mmAuthor = mmDic["author"] as! NSDictionary
            
            let model = NetPictureModel(nickName: mmAuthor["nickname"] as! String,
                                        height: mmAuthor["height"] as! String,
                                        weight: mmAuthor["weight"] as! String,
                                        bwh: mmAuthor["bwh"] as! String,
                                        birthday: mmAuthor["birthday"] as! String,
                                        pictureCount: mmDic["pictureCount"] as! Int,
                                        headerUrl: mmAuthor["headerUrl"] as! String,
                                        headImageFilename: mmDic["headImageFilename"] as! String,
                                        title: mmDic["title"] as! String,
                                        issue: mmDic["issue"] as! Int,
                                        catalog: mmSource["catalog"] as! String,
                                        ID: mmDic["id"] as! Int)
            result.append(model)
        }
        return result
    }
}













