//
//  UITableView.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 03.07.2022.
//

import UIKit

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }
    
    func registerCellWithNib<T: UITableViewCell>(cellClass: T.Type, bundle: Bundle? = nil) {
        let name = String(describing: cellClass)
        let nib = UINib(nibName: name, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: name)
    }
}
