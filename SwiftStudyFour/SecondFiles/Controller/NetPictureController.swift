//
//  NetPictureController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/9.
//  Copyright © 2018年 wg. All rights reserved.
//

import UIKit
import MJRefresh

class NetPictureController: UIViewController {

    let tableView = UITableView(frame: WgRect, style: .grouped)
    let identifier = "Cell"
    var dataArr = [NetPictureModel]()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        queryData()
    }
    
    func setBaseView() {
        self.view.backgroundColor = UIColor.white
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NetPictureCell.self, forCellReuseIdentifier: identifier)
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.queryData()
        })
        /*
        利用SnapKit约束 开启自动计算cell高度
        1.【重点】注意千万不要实现行高的代理方法，否则无效：heightForRowAt
         tableView.estimatedRowHeight = 44//预估高度，随便设置
         tableView.rowHeight = UITableViewAutomaticDimension
         
        2.或者同时实现代理方法，heightForRowAt和estimatedHeightForRowAt
        */
        view.addSubview(tableView)
    }
    
    func queryData() {
        WGHud.showHud(title: "正在加载。。。", detail: "请稍后")
        SendNetQequest.postPage(page: page) { (result, error) in
            if error == nil {
                print("网络请求结果成功:\(String(describing: result))")
                self.dataArr.append(contentsOf: NetPictureModel.AppendData(data: result))
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                    self.page += 1
                    WGHud.hideHud()
                    self.tableView.mj_footer.endRefreshing()
                }
            }else {
                print("网络请求结果失败:\(String(describing: error?.localizedFailureReason))")
                OperationQueue.main.addOperation {
                    WGHud.hideHud()
                    self.tableView.mj_footer.endRefreshing()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension NetPictureController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! NetPictureCell
        cell.setUI(model: dataArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}











