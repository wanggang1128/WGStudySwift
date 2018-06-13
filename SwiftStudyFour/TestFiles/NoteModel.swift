//
//  NoteModel.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/6.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class NoteModel: NSObject {
    var date: Date?
    var content: String?
    init(date: Date, content: String) {
        self.date = date
        self.content = content
    }
}
