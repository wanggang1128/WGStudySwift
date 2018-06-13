//
//  FMDBTestViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/26.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class FMDBTestViewController: WGMainViewController {
    
    let tableV = UITableView(frame: WgRect, style: .grouped)
    let identifier = "cell"
    var dbDatas: [Dictionary<String, String>]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBaseView()
        setDbData()
    }
    
    func setBaseView() {
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUsers))
        tableV.delegate = self
        tableV.dataSource = self
        tableV.backgroundColor = UIColor.white
        view.addSubview(tableV)
    }
    
    func setDbData() {
        WGDBManager.createDBTable(tableName: .userTable, fileName: "spdb")
        dbDatas = WGDBManager.getData(tableName: .userTable, condition: "", fileName: "spdb")
    }
    
    @objc func addUsers() {
        let alert = UIAlertController(title: "添加用户", message: "输入内容", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let add = UIAlertAction(title: "确定", style: .destructive) { (action) in
            let userName = alert.textFields?[0].text
            let passWord = alert.textFields?[1].text
            if ((userName?.count)! < 1) || ((passWord?.count)! < 1) {
                return
            }
            let dic = ["userName" : userName, "passWord" : passWord]
            self.dbDatas?.append(dic as! [String : String])
            self.tableV.reloadData()
            WGDBManager.saveData(tableName: .userTable, contentDic: dic as! Dictionary<String, String>, fileName: "spdb")
        }
        alert.addTextField { (textFeild) in
            textFeild.placeholder = "请输入用户名:"
            textFeild.clearButtonMode = UITextFieldViewMode.whileEditing
        }
        alert.addTextField { (textFeild) in
            textFeild.placeholder = "请输入密码:"
            textFeild.clearButtonMode = UITextFieldViewMode.whileEditing
        }
        alert.addAction(cancel)
        alert.addAction(add)
        self.present(alert, animated: true, completion: nil)
    }
}

extension FMDBTestViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dbDatas?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: .value1, reuseIdentifier: identifier)
        let dic = dbDatas![indexPath.row]
        cell.textLabel?.text = "用户名：" + dic["userName"]!
        cell.detailTextLabel?.text = "密码：" + dic["passWord"]!
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 5))
        cell.textLabel?.textColor = .orange
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "删除") { (action, index) in
            let alert = UIAlertController(title: "提示", message: "是否删除", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let sure = UIAlertAction(title: "确定", style: .destructive, handler: { (act) in
                let dic = self.dbDatas![indexPath.row]
                self.dbDatas?.remove(at: indexPath.row)
                WGDBManager.deleteData(tableName: .userTable, condition: "userName = '\((dic["userName"])!)'", fileName: "spdb")
                self.tableV.reloadData()
            })
            alert.addAction(cancel)
            alert.addAction(sure)
            self.present(alert, animated: true, completion: nil)
        }
        delete.backgroundColor = UIColor.red
        
        let update = UITableViewRowAction(style: .normal, title: "修改") { (action, index) in
            let alert = UIAlertController(title: "提示", message: "是否修改", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let sure = UIAlertAction(title: "确定", style: .destructive, handler: { (act) in
                var dic = self.dbDatas![indexPath.row]
                print("修改前:\(dic)")
                if alert.textFields![0].text == dic["userName"] {
                    dic.updateValue( alert.textFields![1].text!, forKey: "passWord")
                    self.dbDatas![indexPath.row] = dic
                    print("修改后:\(dic)")
                    WGDBManager.updataData(tableName: .userTable, contentDic: dic, fileName: "spdb")
                    self.tableV.reloadData()
                }else{
                    print("原始密码不正确")
                }
            })
            alert.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "请输入原密码:"
                textField.clearButtonMode = UITextFieldViewMode.whileEditing
            })
            alert.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "请输入新密码:"
                textField.clearButtonMode = UITextFieldViewMode.whileEditing
            })
            alert.addAction(cancel)
            alert.addAction(sure)
            self.present(alert, animated: true, completion: nil)
        }
        update.backgroundColor = UIColor.yellow
        return [delete, update]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}















