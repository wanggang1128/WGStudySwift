//
//  URLSessionViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/14.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

let imageURL = "http://c.hiphotos.baidu.com/zhidao/pic/item/5ab5c9ea15ce36d3c704f35538f33a87e950b156.jpg"

class URLSessionViewController: WGMainViewController {

    let titleArr = ["dataTask", "downloadData", "customDownload", "deledateDownload"]
    var imageView = [UIImageView]()
    let viewModel = URLSessionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseView()
    }
    
    func setBaseView() {
        view.backgroundColor = UIColor.lightGray
        for (index,(x,y)) in [(0,0),(1,0),(0,1),(1,1)].enumerated() {
            imageView.append(UIImageView(frame: CGRect(x: (WgWith/2)*CGFloat(x), y: (WgHeight/2)*CGFloat(y), width: WgWith/2, height: WgHeight/2)))
            imageView[index].backgroundColor = UIColor.white
            
            let titleLab = UILabel(frame: CGRect(x: 0, y: imageView[index].frame.size.height-20, width: imageView[index].frame.size.width, height: 20))
            titleLab.textColor = UIColor.blue
            titleLab.textAlignment = .center
            titleLab.text = titleArr[index]
            imageView[index].addSubview(titleLab)
            view.addSubview(imageView[index])
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = touches.first?.location(in: view) {
            switch (point.x, point.y) {
            case (0...WgWith/2, 0...WgHeight/2):
                viewModel.loadDataData(urlString: imageURL, type:.dataTask, success: { (data) in
                    DispatchQueue.main.async {
                        self.imageView[0].image = UIImage(data: data as! Data)
                    }
                }, failure: { (data) in
                    print("左上区域被点击下载失败")
                })
                print("左上区域被点击")
            case (WgWith/2...WgWith, 0...WgHeight/2):
                viewModel.loadDataData(urlString: imageURL, type: .downloadData, success: { (data) in
                    DispatchQueue.main.async {
                        self.imageView[1].image = UIImage(data: data as! Data)
                    }
                }, failure: { (data) in
                    print("右上区域被点击下载失败")
                })
                print("右上区域被点击")
            case (0...WgWith/2, WgHeight/2...WgHeight):
                viewModel.loadDataData(urlString: imageURL, type: .customDownload, success: { (data) in
                    DispatchQueue.main.async {
                        self.imageView[2].image = UIImage(data: data as! Data)
                    }
                }, failure: { (data) in
                    print("左下区域被点击下载失败")
                })
                print("左下区域被点击")
            default :
                viewModel.loadDataData(urlString: imageURL, type: .deledateDownload, success: { (data) in
                    DispatchQueue.main.async {
                        //现在有个问题，这句代码也走了，但是图片显示不出来，只有在第一次的时候才会显示
                        self.imageView[3].image = UIImage(data: data as! Data)
                    }
                }, failure: { (data) in
                    print("右下区域被点击下载失败")
                })
                print("右下区域被点击")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
