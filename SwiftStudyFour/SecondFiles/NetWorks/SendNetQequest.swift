//
//  SendNetQequest.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/9.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit
import AFNetworking

//数据是网上抓来的，只用于学习用，请勿用于别用！
let MainHeader = "http://api.pmkoo.cn/aiss/suite/suiteList.do" //POST body: page 1
let HeadImage = "http://com-pmkoo-img.oss-cn-beijing.aliyuncs.com/header/" //GET + headerUrl
let ImageHead = "http://com-pmkoo-img.oss-cn-beijing.aliyuncs.com/picture/" //GET + catalog + issue + headImageFileName

class SendNetQequest: NSObject {
    
    static func postPage(page: Int, finished: @escaping (_ result: Any?, _ err: NSError?)->Void) {
//        let successBack = {(task: URLSessionDataTask, result: Any?)->Void in finished(result, nil)
//        }
        let failedBack = {(task: URLSessionDataTask?, error: NSError)->Void in finished(nil, error)
        }
        
        AFHTTPSessionManager().post(MainHeader, parameters: ["page": page], progress: nil, success: { (taskk, res) in
            finished(res, nil)
        }, failure: failedBack as? (URLSessionDataTask?, Error) -> Void)
    }
}
