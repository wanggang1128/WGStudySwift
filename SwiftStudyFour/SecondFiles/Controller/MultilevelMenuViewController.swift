//
//  MultilevelMenuViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/22.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class MultilevelMenuViewController: WGMainViewController {

    let tableView = UITableView(frame: WgRect, style: .grouped)
    let identifier = "cell"
    let headIdentifier = "headView"
    var dataArr = [Province]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseView()
        setData()
    }
    
    func setBaseView() {
        view.backgroundColor = UIColor.white
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MultilevelMenuHeadView.self, forHeaderFooterViewReuseIdentifier: headIdentifier)
        view.addSubview(tableView)
    }
    
    func setData() {
        dataArr = MultilevelModel().initData()
    }
}

extension MultilevelMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr[section].isOpening ? dataArr[section].citys.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: .value1, reuseIdentifier: identifier)
        let city = dataArr[indexPath.section].citys[indexPath.row]
        cell.textLabel?.text = city.name
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.textColor = UIColor.cyan
        cell.detailTextLabel?.text = city.alias
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = MultilevelMenuHeadView(reuseIdentifier: headIdentifier) as MultilevelMenuHeadView
        headView.setUI(provice: dataArr[section])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(headTap(sender:)))
        tap.tag = section
        headView.addGestureRecognizer(tap)
        
        return headView
    }
    
    @objc func headTap(sender: UITapGestureRecognizer) {
        dataArr[sender.tag].isOpening = !dataArr[sender.tag].isOpening
        tableView.reloadSections([sender.tag], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

extension UITapGestureRecognizer {
    private struct AddProperty {
        static var tag: Int = 0
    }
    
    var tag: Int {
        get {
            return objc_getAssociatedObject(self, &AddProperty.tag) as! Int
        }
        set {
            objc_setAssociatedObject(self, &AddProperty.tag, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}













