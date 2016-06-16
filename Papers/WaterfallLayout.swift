//
//  WaterfallLayout.swift
//  Papers
//
//  Created by Artem Lyksa on 6/16/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

protocol WaterfallLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath: NSIndexPath) -> CGFloat
}

class WaterfallLayout: UICollectionViewLayout {
    
    var delegate = WaterfallLayoutDelegate!()
    var numberOfColumns = 1
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var width: CGFloat {
        get {
            return CGRectGetWidth(collectionView!.bounds)
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepareLayout() {
        if cache.isEmpty {
            let columnWidth = width / CGFloat(numberOfColumns)
            var xOffsets = [CGFloat]()
            
            for column in 0..<numberOfColumns {
                xOffsets.append(CGFloat(column)*columnWidth)
            }
            var yOffsets = [CGFloat](count:numberOfColumns, repeatedValue: 0)
            var column = 0
            
            for item in 0..<collectionView!.numberOfItemsInSection(0) {
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                let height = delegate.collectionView(collectionView!, heightForItemAtIndexPath: indexPath)
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = frame
                
                cache.append(attributes)
                
                contentHeight = max(contentHeight, CGRectGetMaxY(frame))
                yOffsets[column] = yOffsets[column] + height
                
                if column == (numberOfColumns - 1) {
                    column = 0
                } else {
                    column = 1
                }
            }
        }
    }
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in cache {
            if CGRectIntersectsRect(attribute.frame, rect) {
                attributes.append(attribute)
            }
        }
        return attributes
    }
}












