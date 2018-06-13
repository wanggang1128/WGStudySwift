//
//  WGAlamofireTestVC.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/18.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let SERVICE_URL     = "http://v.juhe.cn/toutiao/index?"   // 请求地址
let SERVICE_IMG_URL = "https://httpbin.org/image/png"     // 图片 url
let APPKEY          = "ad2908cae6020addf38ffdb5e2255c06"  // 应用 APPKEY
let TOP             = "top"                               // 参数：头条
let SHEHUI          = "shehui"                            // 参数：社会
let YULE            = "yule"                              // 参数：娱乐

typealias handle = (_ amount: Int) -> Void
typealias addHandle = (_ one: Int, _ two: Int) -> Void

class WGAlamofireTestVC: WGMainViewController {
    
    var xValue = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseView()
//        firstMethod()
//        secondMethod()
//        thirdMethod()
        //可选类型转换
//        fourMethod()
        let result01 = makeIncrementer(forIncrementer: 4)()
        let result02 = makeIncrementer(forIncrementer: 3)()
        print("闭包,内嵌函数结果01:\(result01)")
        print("闭包,内嵌函数结果02:\(result02)")
        
        escaping { (amount) in
            self.xValue += amount
            print("逃逸闭包结果:",self.xValue)
        }
        noEscaping { (amount) in
            xValue += amount
            print("非逃逸闭包结果:",xValue)
        }
        add(one: 12, two: 13) { (one, two) in
            print("逃逸闭包加法运算结果:\(one+two)")
        }
    }
    
    func setBaseView() {
        view.backgroundColor = UIColor.white
    }
    
    //MARK: 五种不同响应方式
    func firstMethod() {
        let urlStr = "\(SERVICE_URL)type=\(TOP)&key=\(APPKEY)"
        
        /*
         1. response()
         官方解释：The response handler does NOT evaluate any of the response data. It merely forwards on all information directly from the URL session delegate. It is the Alamofire equivalent of using cURL to execute a Request.
         */
        request(urlStr).response { (res) in
            if let data = res.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("firstMethod-->response()-->utf8Text:\(utf8Text)")
            }
        }
        
        /*
         2.responseData()
         官方解释：The responseData handler uses the responseDataSerializer (the object that serializes the server data into some other type) to extract the Data returned by the server. If no errors occur and Data is returned, the response Result will be a .success and the value will be of type Data.
        */
        request(urlStr).responseData { (res) in
            debugPrint("firstMethod-->responseData()-->res:\(res)")
            if let data = res.data, let utf8Text = String(data: data, encoding: .utf8){
                print("firstMethod-->responseData()-->utf8Text:\(utf8Text)")
            }
        }
        
        /*
          3. responseString()
          官方解释：The responseString handler uses the responseStringSerializer to convert the Data returned by the server into a String with the specified encoding. If no errors occur and the server data is successfully serialized into a String, the response Result will be a .success and the value will be of type String.
        */
        request(urlStr).responseString { (res) in
            debugPrint("firstMethod --> responseString() --> Sucess = \(res.result.isSuccess)")
            print("firstMethod --> responseString() --> returnResult = \(res)")
        }
        
        /*
          4. responseJSON()
          官方解释：The responseJSON handler uses the responseJSONSerializer to convert the Data returned by the server into an Any type using the specified JSONSerialization.ReadingOptions. If no errors occur and the server data is successfully serialized into a JSON object, the response Result will be a .success and the value will be of type Any.
        */
        request(urlStr).responseJSON { (res) in
            debugPrint("firstMethod --> responseJSON() --> \(res)")
            if let json = res.result.value {
                print("firstMethod --> responseJSON() --> \(json)")
                print("firstMethod --> responseJSON() --> 使用SwiftJson处理后\(JSON(json))")
            }
        }
    }

    //MARK: 请求方法、参数、编码、请求头等
    func secondMethod() {
        /*
         public enum HTTPMethod: String {
         case options = "OPTIONS"
         case get     = "GET"
         case head    = "HEAD"
         case post    = "POST"
         case put     = "PUT"
         case patch   = "PATCH"
         case delete  = "DELETE"
         case trace   = "TRACE"
         case connect = "CONNECT"
         }
         */
        
        let urlStr = "\(SERVICE_URL)type=\(YULE)&key=\(APPKEY)"
        let param = [
            "type":YULE,
            "key":APPKEY
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        //get请求
        request(urlStr, method: .get).responseJSON { (res) in
            print("secondMethod --> GET 请求 --> res = \(JSON(res.result.value!))")
        }
        
        //post请求
        request(urlStr, method: .post).responseJSON { (res) in
            let json = JSON(res.result.value!)
            print("secondMethod --> POST 请求 --> res = \(json)")
        }
        
        request(urlStr, method: .post, parameters: param, encoding: URLEncoding.default, headers: headers).responseJSON { (res) in
            print("secondMethod --> 参数,请求头，编码 --> res = \(JSON(res.result.value!))")
        }
    }

    //MARK:下载图片
    let destination: DownloadRequest.DownloadFileDestination = {_,res in
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileUrl = documentsUrl?.appendingPathComponent(res.suggestedFilename!)
        return (fileUrl!,[.removePreviousFile, .createIntermediateDirectories])
    }
    func thirdMethod() {
        download(SERVICE_IMG_URL, to: destination).downloadProgress { (progress) in
            print("download progress = \(progress.fractionCompleted)")
            }.responseData { (res) in
                if let data = res.result.value {
                    let image = UIImage(data: data)
                    if let img = image {
                        print("下载的图片:\(img)")
                    }
                }else{
                    print("图片现在失败！")
                }
        }
    }

    //可选类型转换
    func fourMethod() {
        let arr = ["123", 456] as [Any]
        for index in arr {
            let val = index as? Int
            if let v = val {
                print(v)
            }else{
                print("解析失败")
            }
        }
        var score: [String: Int] = ["语文": 87, "数学": 99, "英语": 61]
//        let removedValue = score.removeValue(forKey: "物理") // 返回nil
        let removedValue = score.removeValue(forKey: "英语")
        if let value = removedValue {
            print(value)
        }else{
            print("删除失败")
        }
        
        
//        var firstStr: String?  //可选类型，初始值为nil
//        var secondStr: String? = "可选变量"  //可选类型
//        var thirdStr: String!  //隐式可选类型，初始值nil
//        var fourthStr: String! = "隐式可选变量" //隐式可选类型
//
//        print("firstStr:" + firstStr!)
//        print("secondStr:" + secondStr!)
//        print("thirdStr:" + thirdStr)
//        print("fourthStr:" + fourthStr)
    }
    
    //闭包   一个能捕获值的闭包最简单的模型是内嵌函数
    func makeIncrementer(forIncrementer amount: Int) ->() ->Int {
        var runingTotal = 1
        func incrementer() ->Int {
            runingTotal  *= amount
            return runingTotal
        }
        return incrementer
    }
    
    //逃逸闭包
    func escaping(completeHandle: @escaping handle) {
        completeHandle(3)
    }
    //非逃逸闭包
    func noEscaping(complete:handle) {
        complete(4)
    }
    //
    func add(one: Int, two: Int, completeHandle:@escaping addHandle){
        completeHandle(one, two)
    }
}










