//
//  PictureBrowseViewController.swift
//  SwiftStudyFour
//
//  Created by hanlei on 2017/12/8.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

class PictureBrowseViewController: WGMainViewController {

    var collectionView: UICollectionView!
    let identifier = "cell"
    let dataArr = PictureBrowseModel.createData()
    let backgroundImgView = UIImageView(frame: WgRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBaseView()
    }
    
    func setBaseView() {
        self.view.backgroundColor = UIColor.white
        backgroundImgView.image = UIImage(named: "blue")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ItemWidth, height: ItemHeight)
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 20.0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: (WgHeight-ItemHeight)*0.5, width: WgWith, height: ItemHeight), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(PictureBrowseCell.self, forCellWithReuseIdentifier: identifier)
        self.view.addSubview(backgroundImgView)
        self.view.addSubview(collectionView)
    }
}

extension PictureBrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PictureBrowseCell
        cell.dataModel = dataArr[indexPath.row]
        return cell
    }
}
















