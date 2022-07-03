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
    }
    
    func updateNavBar() {
        let bgImage = UIImage(named: "BGFinal2.png")
        self.tabBarController?.tabBar.backgroundImage = bgImage
    }
    
}
