//
//  AtabbarViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/21.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class AtabbarViewController: WGMainViewController {

    let tableV = UITableView(frame: WgRect, style: .grouped)
    let identifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.isNavigationBarHidden = false
        
        animateTable()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func setBaseView() {
        view.backgroundColor = UIColor.white
        tableV.backgroundColor = UIColor.white
        tableV.delegate = self
        tableV.dataSource = self
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        view.addSubview(tableV)
    }
    
    func animateTable() {
        let cells = tableV.visibleCells
        let height = WgHeight
        
        for i in cells {
            i.transform = CGAffineTransform(translationX: 0, y: height)
        }
        
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: 1, delay: 0.05*Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AtabbarViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}








