//
//  PromptModel.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/2.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit

struct PromptModel {
    var promptType: UserStoreState
    init(pType: UserStoreState) {
        self.promptType = pType
    }
}
