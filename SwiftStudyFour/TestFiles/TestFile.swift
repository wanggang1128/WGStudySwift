//
//  TestFile.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/7.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

enum ErrorType: Error {
    case NoData
    case primaryKeyNull
}

class TestFile: NSObject {
    
    static let testFile = TestFile()
    //swift调用OC代码
    func swiftByOC() {
        let obc = ObcFileTest()
        obc.initWithname("桥接成功了")
        print("桥接文件实验:\(obc.name)")
    }
    
    //异常等
    func myNotesTest() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        let note = NoteManager()
        do {
            let da = dateFormatter.date(from: "2017-11-01 16:03:03")
            let model = NoteModel(date: da!, content: "123")
            try note.removeData(model: model)
        } catch ErrorType.NoData {
            print("333")
        } catch {
            print("444")
        }
    }
    
    //MARK: 方法注释
    //json转字典打印实验
    func jsonPrint() {
        let jsonString:String = "{\"names\":[\"James\",\"Jobs\",\"Tom\"]}"
        let jsonData = jsonString.data(using: String.Encoding.utf8)
        do {
            let dic = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)
            print("json字典\(dic)")
        } catch {
            
        }
    }
    
    //TODO: 这里的代码有没有完成或者还要处理
    // 书上扩展，协议等实验
    func bookTest() {
        
        let message = (-1).errorMessage
        print("扩展Int打印信息:\(message)")
        
        let moneyOne = (1000.00).caculateRateOne()
        print("扩展Double方法1:\(moneyOne)")
        var moneyTwo = 1000.00
        moneyTwo.caculateRateTwo()
        print("扩展Double方法2:\(moneyTwo)")
        print("扩展Double方法3:\(Double.caculateRateThree(amount: 1000.00))")
        
        let rectangle = Rectangle(with: 10.00, height: 20.00)
        print("值类型扩展构造函数:\(rectangle.area)")
        let square = Rectangle(length: 10)
        print("正方形面积:\(square.area)")
        
        let str = "haohaoxuexi tiantianxiangshang"
        print("扩展下表:\(str.sub(index: 3))")
        print("扩展下表2:\("12345".sub(index: 3))")
        
        let stu1 = Student(fir: "zhang", last: "san", school: "qinghua")
        let stu2 = Student(fir: "li", last: "si", school: "beida")
        let work1 = Worker(fir: "wang", last: "wu", factory: "kelan")
        let work2 = Worker(fir: "zhao", last: "liu", factory: "wangyi")
        let person: [Person] = [stu1, stu2, work1, work2]
        for per in person {
            if let student = per as? Student {
                student.stuDeledate = student as Person
                print("学生学校:\(student.school)")
                print("学生firstName:\(student.firstName)")
                print("学生lastName:\(student.lastName)")
//                print(("学生description:\(student.description())"))
                print(("学生description:\(String(describing: student.stuDeledate?.description()))"))
            }else if let worker = per as? Worker {
                print("工人公司:\(worker.factory)")
                print("工人firstName:\(worker.firstName)")
                print("工人lastName:\(worker.lastName)")
                print("工人description:\(worker.description())")
            }
        }
    }
}
