//
//  WGHud.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/10.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit
import MBProgressHUD

class WGHud: NSObject {
    
    private static var show: MBProgressHUD?
    
    static func showHud(title: String, detail: String) {
        if let hud = show {
            hud.hide(animated: true)
        }
        show = MBProgressHUD()
        UIApplication.shared.keyWindow?.addSubview(show!)
        show?.label.text = title
        show?.detailsLabel.text = detail
        show?.label.font = UIFont.systemFont(ofSize: 13.0)
        show?.detailsLabel.font = UIFont.systemFont(ofSize: 11.0)
        show?.isSquare = true
        show?.removeFromSuperViewOnHide = true
        show?.show(animated: true)
        
        //15秒后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+15) {
            if let hud = show {
                hud.hide(animated: true)
            }
        }
    }
    
    static func hideHud() {
        if let hud = show {
            hud.hide(animated: true)
        }
    }
}











