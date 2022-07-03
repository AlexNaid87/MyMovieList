//
//  UIImageView.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 03.07.2022.
//

import UIKit

extension UIImageView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
