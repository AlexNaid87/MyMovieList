//
//  CustomLayout.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 22.05.2022.
//

import UIKit

class CustomLayout: UICollectionViewFlowLayout {
    
    var previosOffset: CGFloat = 0.0
    var currentPage = 0
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let cv = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        let itemCount = cv.numberOfItems(inSection: 0)
        
        if previosOffset > cv.contentOffset.x && velocity.x < 0.0 {
            //<-
            currentPage = max(currentPage-1, 0)
        } else if previosOffset < cv.contentOffset.x && velocity.x > 0.0 {
            //->
            currentPage = min(currentPage+1, itemCount-1)
        }
        let offset = updateOffset(cv)
        previosOffset = offset
        
        return CGPoint(x: offset, y: proposedContentOffset.y)
    }
    
    func updateOffset(_ cv: UICollectionView) -> CGFloat {
        let w = cv.frame.width
        let itemW = itemSize.width
        let sp = minimumLineSpacing
        let edge = (w - itemW - sp*2) / 2
        let offset = (itemW + sp) * CGFloat(currentPage) - (edge + sp)
        
        return offset
    }
}