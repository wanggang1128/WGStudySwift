//
//  TabBarViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/21.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        selectedIndex = 0
        selectedViewController = viewControllers?[selectedIndex]
    }
    
    func setBaseView() {
        let avc = AtabbarViewController()
        let bvc = BtabbarViewController()
        let cvc = CtabbarViewController()
        viewControllers = [setTabBarVc(controller: avc, tabTitle: "A", image: "Game", showNavigation: false), setTabBarVc(controller: bvc, tabTitle: "B", image: "Home", showNavigation: false), setTabBarVc(controller: cvc, tabTitle: "C", image: "Setting", showNavigation: false)]
    }
    
    func setTabBarVc(controller: UIViewController, tabTitle: String, image: String, showNavigation: Bool = true) -> UIViewController {
        controller.title = image
        controller.tabBarItem.title = tabTitle
        controller.tabBarItem.image = UIImage(named: image)
        if showNavigation {
            let nav = UINavigationController(rootViewController: controller)
            return nav
        }
        return controller
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
