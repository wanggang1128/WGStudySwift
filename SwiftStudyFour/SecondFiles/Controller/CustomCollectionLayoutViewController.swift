//
//  CustomCollectionLayoutViewController.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/18.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

enum CustomType {
    case line
    case waterFall
    case circle
}

class CustomCollectionLayoutViewController: WGMainViewController {

    var collectionView: UICollectionView!
    let identifier = "collectionCell"
    var type: CustomType = CustomType.line
    var cellCount = 0
    var cellHeight = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseView()
    }
    
    func setBaseView() {
//        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.white
        collectionView = UICollectionView(frame: WgRect, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = UIColor.yellow
        switch type {
        case .circle:
            cellCount = 10
            setWaterFallLayout()
        case .line:
            cellCount = 50
            setWaterFallLayout()
        default:
            cellCount = 100
            setWaterFallLayout()
            for _ in 0..<self.cellCount {
                cellHeight.append(CGFloat(arc4random() % 150 + 40))
            }
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        view.addSubview(collectionView)
    }
    func setWaterFallLayout() {
        let layout = WaterFallLayout()
        layout.deledate = self
        layout.numOfColum = 4
        collectionView.collectionViewLayout = layout
    }
}

extension CustomCollectionLayoutViewController: UICollectionViewDelegate, UICollectionViewDataSource, WaterFallLayoutDelegete {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        return cell
    }
    func heightForItemAtIndexPath(indexPath: IndexPath) -> CGFloat {
        return cellHeight[indexPath.row]
    }
}








