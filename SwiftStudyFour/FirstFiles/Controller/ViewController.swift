//
//  ViewController.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/4.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

let WgRect = UIScreen.main.bounds
let WgWith = WgRect.size.width
let WgHeight = WgRect.size.height

class ViewController: UIViewController, ProDelegate {

    var tableView: UITableView?
    let indenrifier = "cell"
    var cellArray: [ViewControllerCellModel] = ViewControllerCellModel.baseCellArr()
    let userManager = UserInfoManager.userInfoManagerShared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setBaseView()
//        textFunc()
        //验证swift中的runtime
        runtimeInSwiftTest()
    }
    
    func runtimeInSwiftTest(){
        let textASwift = TextASwiftClass()
        let textSwift = TextSwiftClass()
        RuntimeInSwift.showClsRuntime(cls: object_getClass(textASwift)!)
        print("+++++++++++++++++++++")
        RuntimeInSwift.showClsRuntime(cls: object_getClass(textSwift)!)
    }
    
    func textFunc() {
        let deleC: ProClass = ProClass()
        deleC.delegate = self
        deleC.backAction()
    }
    
    func text01() {
        print("可选协议验证")
    }
    
    func text02(name: String, type: Int) {
        print("name:\(name),type:\(type)")
    }
    
    func setBaseView() {
        self.view.backgroundColor = UIColor.white
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: WgWith, height: WgHeight-64), style: .grouped)
        tableView?.backgroundColor = UIColor.white
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: indenrifier)
        self.view.addSubview(tableView!)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, PSelectDeledate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indenrifier, for: indexPath)
        cell.textLabel?.text = cellArray[indexPath.row].titleStr
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(SecondViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(PictureBrowseViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(RefreshViewController(), animated: true)
        case 3:
            self.navigationController?.pushViewController(GradientLayViewController(), animated: true)
        case 4:
            self.navigationController?.pushViewController(PickerViewViewController(), animated: true)
        case 5:
            self.navigationController?.pushViewController(URLSessionViewController(), animated: true)
        case 6:
            self.navigationController?.pushViewController(SwipeableViewController(), animated: true)
        case 7:
            let conv = CustomCollectionLayoutViewController()
            conv.type = CustomType.waterFall
            self.navigationController?.pushViewController(conv, animated: true)
        case 8:
            let tabbar = TabBarViewController()
            self.navigationController?.pushViewController(tabbar, animated: true)
        case 9:
            self.navigationController?.pushViewController(MultilevelMenuViewController(), animated: true)
        case 10:
            self.navigationController?.pushViewController(VoiceViewController(), animated: true)
        case 11:
            self.navigationController?.pushViewController(FMDBTestViewController(), animated: true)
        case 12:
            userManager.userStateJump(handel: { (userState) in
                switch userState {
                case .failed:
                    let promptView = PromptView(frame: WgRect)
                    promptView.delegate = self
                    UIApplication.shared.keyWindow?.addSubview(promptView)
                    print("门店创建失败")
                case .finished:
                    let promptView = PromptView(frame: WgRect)
                    promptView.delegate = self
                    UIApplication.shared.keyWindow?.addSubview(promptView)
                    print("门店创建完成")
                case .waite:
                    let promptView = PromptView(frame: WgRect)
                    promptView.delegate = self
                    UIApplication.shared.keyWindow?.addSubview(promptView)
                    print("门店创建等待审核")
                default:
                    let promptView = PromptView(frame: WgRect)
                    promptView.delegate = self
                    UIApplication.shared.keyWindow?.addSubview(promptView)
                    print("还没有门店创建")
                }
            })
        case 13:
            self.navigationController?.pushViewController(NetPictureController(), animated: true)
        case 14:
            self.navigationController?.pushViewController(GaoDeViewController(), animated: true)
        case 15:
            self.navigationController?.pushViewController(UIRefreashOnMainthreadTest(), animated: true)
        case 16:
            self.navigationController?.pushViewController(WGAlamofireTestVC(), animated: true)
        case 17:
            self.navigationController?.pushViewController(WGRunTimeTestController(), animated: true)
        case 18:
            self.navigationController?.pushViewController(WGCustomStudyController(), animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func didClicked(isSec: Bool) {
        if isSec {
            self.navigationController?.pushViewController(StoreProgressViewController(), animated: true)
        }
    }
}













