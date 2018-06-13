//
//  PictureBrowseModel.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/8.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class PictureBrowseModel: NSObject {
    var img: String?
    var title: String?
    var detailTitle: String?
    
    init(image: String, title: String, detail: String) {
        self.img = image
        self.title = title
        self.detailTitle = detail
    }
    
    static func createData() -> [PictureBrowseModel] {
        return [
            PictureBrowseModel(image: "hello", title: "Hello there, i miss u.", detail: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨"),
            PictureBrowseModel(image: "dudu", title: "🐳🐳🐳🐳🐳", detail: "We love romantic stories. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨"),
            PictureBrowseModel(image: "bodyline", title: "Training like this, #bodyline", detail: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨"),
            PictureBrowseModel(image: "wave", title: "I'm hungry, indeed.", detail: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨"),
            PictureBrowseModel(image: "darkvarder", title: "Dark Varder, #emoji", detail: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨"),
            PictureBrowseModel(image: "hhhhh", title: "I have no idea, bitch", detail: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨"),
        ]
    }
}
