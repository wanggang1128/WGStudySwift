//
//  PromptViewModel.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/2.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit

struct Tmessage {
    static let withoutMsg = "您当前还没有自己的门店哦！\n开店后就可以进行其他操作喽 ~"
    static let waiteMsg = "您的门店正在审核中，请稍等 ~"
    static let failedMsg = "您的门店审核未通过，请补充资料 ~"
    static let finishedMsg = "审核通过!"
}

protocol PromptProtocol {
    var tMessage: String {get}
    var storeState: UserStoreState {get}
}

class PromptViewModel: PromptProtocol {
    var tMessage: String
    var storeState: UserStoreState
    
    init(model: PromptModel) {
        self.storeState = model.promptType
        switch storeState {
        case .without:
            tMessage = Tmessage.withoutMsg
        case .waite:
            tMessage = Tmessage.waiteMsg
        case .failed:
            tMessage = Tmessage.failedMsg
        default:
            tMessage = Tmessage.finishedMsg
        }
    }
}
