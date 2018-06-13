//
//  RefreshViewController.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/8.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class RefreshViewController: WGMainViewController {

    let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: WgWith, height: WgHeight-64), style: .grouped)
    let identifier = "cell"
    var dataArr = ["1","2","3","4","5","6","7"]
    let newArr = ["8","9","10","11","12"]
    
    let rereshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBaseView()
        
        //隐藏导航栏
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.barStyle = .blackOpaque
//        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    func setBaseView() {
        self.view.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = rereshController
        } else {
        }
        rereshController.backgroundColor = UIColor.gray
        rereshController.tintColor = UIColor.black
        rereshController.attributedTitle = NSAttributedString(string: "最后一次更新:\(NSDate())", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        rereshController.addTarget(self, action: #selector(addContent), for: UIControlEvents.valueChanged)
        
        self.view.addSubview(tableView)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(colorRandomChange), userInfo: nil, repeats: true)
    }
    
    @objc func addContent() {
        dataArr.append(contentsOf: newArr)
        tableView.reloadData()
        rereshController.endRefreshing()
    }
    
    @objc func colorRandomChange() {
        self.view.backgroundColor = UIColor.init(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }

}

extension RefreshViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        cell?.textLabel?.text = dataArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}











