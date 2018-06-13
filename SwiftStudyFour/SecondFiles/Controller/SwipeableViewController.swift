//
//  SwipeableViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/15.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class SwipeableViewController: WGMainViewController {

    let tableView = UITableView(frame: WgRect, style: .grouped)
    let identifier = "cell"
    var dataArr = [SwipeableCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBaseView()
    }

    func setBaseView() {
        for index in 0...20 {
            dataArr.append(SwipeableCellModel(imageName: "\(index % 3 + 1)", titleName: "第\(index)个"))
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SwipeableCell.self, forCellReuseIdentifier: identifier)
        view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SwipeableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SwipeableCell
        cell.buildCell(model: dataArr[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAct = UITableViewRowAction(style: .normal, title: "delete") { (action, index) in
            let alert = UIAlertController(title: "提示", message: "确定删除吗？", preferredStyle: .alert)
            let sureAction = UIAlertAction(title: "确定", style: .destructive, handler: { (act) in
                self.dataArr.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: { (act) in
            })
            alert.addAction(sureAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
        deleteAct.backgroundColor = UIColor.red
        return [deleteAct]
    }
}












