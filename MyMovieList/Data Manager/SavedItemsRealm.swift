//
//  SavedItemsRealm.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 03.05.2022.
//

import Foundation
import RealmSwift

class SavedItems: Object {
   
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var movieDescription = ""
    @objc dynamic var bgPath = ""
    @objc dynamic var posterPath = ""
    @objc dynamic var dateRelese = ""
    @objc dynamic var averageVote = 0.0
    @objc dynamic var homepage = ""
    @objc dynamic var runTime = 0
    @objc dynamic var tagLine = ""
    @objc dynamic var video = false
    @objc dynamic var genres = ""
    
    
}
