//
//  Constance.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 13.05.2022.
//

import Foundation
import SwiftUI

struct GlobalConstants {
    
    static let marginSpace          : Double    = 16
    static let posterSize           : Int       = 500
    static let posterSizeSmall      : Int       = 200
    static let picTMDBurl           : String    = "https://image.tmdb.org/t/p/w"
    static let imbdUrl              : String    = "https://api.themoviedb.org/3/"
    static let api                  : String    = "dc7779f2a307a05dd46746f976ce9642"
    static let imagePlaceholder                 = #imageLiteral(resourceName: "ImageHolder")
    static let youTubeLink          : String    = "https://www.youtube.com/watch?v="
    static let BGimage                          = UIImage(named: "BGFinal2.png")
    static let screenWidth                      = UIScreen.main.bounds.size.width
    static let screenHeight                     = UIScreen.main.bounds.size.height
    static let screenWidthMinusPadding          = screenWidth * 0.95
    static let cornerRadiusCoef                 = 0.05
    
    //MARK: Dementions for main collection view
    static let padding = 50
    
    static var itemW: CGFloat {
        return screenWidth * 0.5
    }
    static var itemH: CGFloat {
        return itemW * 1.5
    }
    
    let wIndex = 0.75
    let hIndex = 1.4
}
