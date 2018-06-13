//
//  URLSessionViewModel.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/14.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

enum SessionType {
    case dataTask
    case downloadData
    case customDownload
    case deledateDownload
}

class URLSessionViewModel: NSObject {
    var model: URLSessionModel?
    override init() {
        super.init()
        model = URLSessionModel()
    }
    func loadDataData(urlString: String, type: SessionType, success: @escaping ((Any?) -> Void), failure: @escaping ((Any?) -> Void)) {
        switch type {
        case .dataTask:
            model?.loadData(urlString: urlString, success: success, failure: failure)
        case .downloadData:
            model?.downloadData(urlString: urlString, success: success, failure: failure)
        case .customDownload:
            model?.customDownloadData(urlString: urlString, success: success, failure: failure)
        default:
            model?.delegeteDownloadData(urlString: urlString, success: success, failure: failure)
            //两种都可以
//            model?.delegeteDownloadData(urlString: urlString, success: { (data) in
//                success(data)
//                print("代理下载接收到数据")
//            }, failure: { (data) in
//                failure(data)
//                print("代理下载失败")
//            })
        }
    }
}
