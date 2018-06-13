//
//  WaterFallLayout.swift
//  SwiftStudyFour
//
//  Created by wanggang on 2017/12/18.
//  Copyright © 2017年 wg. All rights reserved.
//

import UIKit

protocol WaterFallLayoutDelegete {
    func heightForItemAtIndexPath(indexPath: IndexPath) -> CGFloat
}

class WaterFallLayout: UICollectionViewFlowLayout {
    var deledate: WaterFallLayoutDelegete?
    private var maxOfColunm = [CGFloat]()
    private let itemSpace: CGFloat = 5
    private var layoutAttribute = [UICollectionViewLayoutAttributes]()
    var numOfColum = 0 {
        didSet{
            for _ in 0..<numOfColum {
                maxOfColunm.append(0)
            }
        }
    }
    
    override func prepare() {
        super.prepare()
        layoutAttribute = caculateAttributes()
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttribute[indexPath.row]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttribute
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxOfColunm.max()!)
    }
    
    func caculateAttributes() -> [UICollectionViewLayoutAttributes] {
        var x: CGFloat
        var y: CGFloat
        var height: CGFloat
        var currentColum: Int
        var indexPath: IndexPath
        var attributeArr = [UICollectionViewLayoutAttributes]()
        
        let numOfItems = collectionView!.numberOfItems(inSection: 0)
        let width = ((collectionView?.bounds.width)! - itemSpace * (CGFloat(numOfColum) + 1 ))/CGFloat(numOfColum)
        
        guard let wgdelegate = deledate else{
            assert(false, "请设置代理")
            return attributeArr
        }
        for i in 0..<numOfColum {
            self.maxOfColunm[i] = 0
        }
        
        for currentIndex in 0..<numOfItems {
            indexPath = IndexPath(item: currentIndex, section: 0)
            height = wgdelegate.heightForItemAtIndexPath(indexPath: indexPath)
            if currentIndex < numOfColum {
                currentColum = currentIndex
            }else{
                let minY = maxOfColunm.min()!
                currentColum = maxOfColunm.index(of: minY)!
            }
            x = itemSpace + CGFloat(currentColum) * (width + itemSpace)
            y = itemSpace + maxOfColunm[currentColum]
            maxOfColunm[currentColum] = y + height
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = CGRect(x: x, y: y, width: width, height: height)
            attributeArr.append(attribute)
        }
        
        return attributeArr
    }
}
