//
//  UICollectionView.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 03.07.2022.
//

import UIKit

extension UICollectionView {
    
    func registerCellWithNib<T: UICollectionViewCell>(cellClass: T.Type, bundle: Bundle? = nil) {
        let name = String(describing: cellClass)
        let nib = UINib(nibName: name, bundle: bundle)
        self.register(nib, forCellWithReuseIdentifier: name)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
}
