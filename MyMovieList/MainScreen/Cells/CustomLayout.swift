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
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        let itemCount = collectionView.numberOfItems(inSection: 0)
        
        if previosOffset > collectionView.contentOffset.x && velocity.x < 0.0 {
            //<-
            currentPage = max(currentPage-1, 0)
        } else if previosOffset < collectionView.contentOffset.x && velocity.x > 0.0 {
            //->
            currentPage = min(currentPage+1, itemCount-1)
        }
        let offset = updateOffset(collectionView)
        previosOffset = offset
        
        return CGPoint(x: offset, y: proposedContentOffset.y)
    }
    
    func updateOffset(_ collectionView: UICollectionView) -> CGFloat {
        let width = collectionView.frame.width
        let itemWidht = itemSize.width
        let spacing = minimumLineSpacing
        let edge = (width - itemWidht - spacing * 2) / 2
        let offset = (itemWidht + spacing) * CGFloat(currentPage) - (edge + spacing)
        
        return offset
    }
}
