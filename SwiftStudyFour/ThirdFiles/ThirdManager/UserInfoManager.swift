//
//  UserInfoManager.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/2.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit

enum UserStoreState {
    case without
    case waite
    case failed
    case finished
}

class UserInfoManager: NSObject {
    static let userInfoManagerShared = UserInfoManager()
    var userStoreState = UserStoreState.without
    
    func userStateJump(handel: @escaping (_ state: UserStoreState)->Void) {
        switch userStoreState {
        case .without:
            handel(.without)
        case .finished:
            handel(.finished)
        case .waite:
            handel(.waite)
        default:
            handel(.failed)
//            let promptVC = StorePromptViewController()
//            promptVC.storeState = userStoreState
//        UIApplication.shared.keyWindow?.rootViewController?.present(promptVC, animated: true, completion: nil)
//            UIApplication.shared.keyWindow?.addSubview(promptVC.view)
//            UIApplication.shared.delegate?.window??.addSubview(promptVC.view)
//            UIApplication.shared.windows.last?.addSubview(promptVC.view)
        }
    }
}
