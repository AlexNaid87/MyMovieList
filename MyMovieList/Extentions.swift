//
//  Extentions.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 16.06.2022.
//

import UIKit


extension UIViewController {
    func setBackgroundImage(imageName: String, selectedView: UIView) {
        let backgroundImage = UIImage(named: imageName)
        let backgroundImageView = UIImageView(frame: selectedView.frame)
        backgroundImageView.image = backgroundImage
        selectedView.insertSubview(backgroundImageView, at: 0)
    }
    
    func updateNavBar() {
        let bgImage = UIImage(named: "BGFinal2.png")
        self.tabBarController?.tabBar.backgroundImage = bgImage
    }
    
}


extension UIImageView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}


extension AppDelegate {
    func updateNavBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        navigationBarAppearance.backgroundColor = .clear
        navigationBarAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        

        
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithOpaqueBackground()
        tabBarApperance.backgroundColor = .clear
        
        UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
        UITabBar.appearance().standardAppearance = tabBarApperance
       
    }
}



