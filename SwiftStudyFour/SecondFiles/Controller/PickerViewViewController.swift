//
//  PickerViewViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/14.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit
import SnapKit
class PickerViewViewController: WGMainViewController {

    let pickerView = UIPickerView(frame: CGRect(x: 30, y: 64, width: WgWith-60, height: 200))
    let showLab = UILabel(frame: CGRect(x: 0, y: 300, width: WgWith, height: 30))
    let btn = UIButton(frame: CGRect(x: (WgWith-50)/2.0, y: 350, width: 50, height: 30))
    let hours = 0...23
    let minites = 0...59
    let seconds = 0...59
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBaseView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showText()
    }
    
    func setBaseView() {
        self.view.backgroundColor = UIColor.cyan
        pickerView.backgroundColor = UIColor.lightGray
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(0, inComponent: 0, animated: true)
        
        showLab.backgroundColor = UIColor.white
        showLab.textColor = UIColor.brown
        showLab.font = UIFont.systemFont(ofSize: 18)
        showLab.textAlignment = .center
        
        btn.setTitle("选择", for: .normal)
        btn.addTarget(self, action: #selector(randomSelector), for: .touchUpInside)
        btn.setTitleColor(UIColor.blue, for: .normal)
        
        view.addSubview(pickerView)
        view.addSubview(showLab)
        view.addSubview(btn)
    }
    
    @objc func randomSelector() {
        pickerView.selectRow(Int(arc4random())%hours.count, inComponent: 0, animated: true)
        pickerView.selectRow(Int(arc4random())%minites.count, inComponent: 1, animated: true)
        pickerView.selectRow(Int(arc4random())%seconds.count, inComponent: 2, animated: true)
        showText()
    }
    
    func showText() {
        showLab.text = "选择为:\(pickerView.selectedRow(inComponent: 0))时,\(pickerView.selectedRow(inComponent: 1))分,\(pickerView.selectedRow(inComponent: 2))秒"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension PickerViewViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return minites.count
        default:
            return seconds.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return (WgWith-60)/3.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        showText()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLab = UILabel()
        switch component {
        case 0:
            pickerLab.text = String(Array(hours)[row]) + "时"
        case 1:
            pickerLab.text = String(Array(minites)[row]) + "分"
        default:
            pickerLab.text = String(Array(seconds)[row]) + "秒"
        }
        pickerLab.textColor = UIColor.green
        pickerLab.font = UIFont.systemFont(ofSize: 20)
        pickerLab.textAlignment = .center
        
        return pickerLab
    }
}



















