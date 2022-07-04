//
//  UIViewController.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 03.07.2022.
//

import UIKit

extension UIViewController {
    func setBackgroundImage(selectedView: UIView) {
        let backgroundImage = GlobalConstants.BGimage
        let backgroundImageView = UIImageView(frame: selectedView.frame)
        backgroundImageView.image = backgroundImage
        selectedView.insertSubview(backgroundImageView, at: 0)
        backgroundImageView.contentMode = .scaleToFill
    }
    
    func updateNavBar() {
        let bgImage = GlobalConstants.BGimage
        self.tabBarController?.tabBar.backgroundImage = bgImage
        self.tabBarController?.tabBar.contentMode = .scaleToFill
    }
    
}
