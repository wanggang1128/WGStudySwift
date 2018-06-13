//
//  URLSessionModel.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/14.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

typealias resultBlock = (Any?) -> Void

class URLSessionModel: NSObject {
    
    var successResult: resultBlock?
    var failureResult: resultBlock?
    
    //使用全局的session实例，该实例没有代理对象，无法检测下载进度，也无法设置后台下载。
    func loadData(urlString: String, success: @escaping resultBlock, failure: @escaping resultBlock) {
        if let url = URL.init(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                /*data:获得的数据  response:回复  error:错误*/
                if error == nil{
                    success(data)
                }else {
                    failure(error)
                }
            }).resume()//resume必须调用，才会访问url
        }
    }
    
    /*urlsession的task有三种：
     1:dataTask,普通的读取服务端数据操作
     2:downloadTask,下载文件
     3:uploadTask,上传文件
     */
    func downloadData(urlString: String, success: @escaping resultBlock, failure: @escaping resultBlock) {
        if let url = URL(string: urlString) {
            URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) in
                /*location:下载好的文件位置(该文件临时缓存，需要移动出来)  response:回复  error:错误*/
                if error == nil {
                    do {
                        try success(Data(contentsOf: location!))
                    }catch let err as NSError {
                        failure(err)
                    }
                }else {
                    failure(error)
                }
            }).resume()
        }
    }
    
    func customDownloadData(urlString: String, success: @escaping resultBlock, failure: @escaping resultBlock) {
        if let url = URL.init(string: urlString) {
            /*URLSessionConfiguration可以进行很多配置，比如timeoutIntervalForRequest、timeoutIntervalForResource控制网络超时时间，allowsCellularAccess:是否可以使用无线网络，HTTPAdditionalHeaders:指定http请求头等*/
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            session.downloadTask(with: url, completionHandler: { (location, respomnse, error) in
                if error == nil {
                    do {
                        try success(Data(contentsOf: location!))
                    }catch let err as NSError {
                        failure(err)
                    }
                }else {
                    failure(error)
                }
            }).resume()
        }
    }
    
    func delegeteDownloadData(urlString: String, success: @escaping resultBlock, failure: @escaping resultBlock) {
        if let url = URL.init(string: urlString) {
            let configuretion = URLSessionConfiguration.background(withIdentifier: "download")
            let session = URLSession(configuration: configuretion, delegate: self, delegateQueue: nil)
            session.downloadTask(with: url).resume()
            self.successResult = success
            self.failureResult = failure
        }
    }
}

extension URLSessionModel: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            try self.successResult!(Data(contentsOf: location))
        }catch let err as NSError {
            self.failureResult!(err)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("下载进度：\(totalBytesWritten)/\(totalBytesExpectedToWrite)")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print("从\(fileOffset)处恢复下载，一共\(expectedTotalBytes)")
    }
}
