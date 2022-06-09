//
//  DataManager.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 03.05.2022.
//

import Foundation
import RealmSwift

class DataManager {
    
    static let shared = DataManager()
    private init() { }

    
    let realm = try? Realm()
        
    func save(_ itemTitle: MovieDetails ) {
        
        let item                = SavedItems()
        item.id                 = itemTitle.id ?? 0
        item.title              = itemTitle.title ?? ""
        item.movieDescription   = itemTitle.overview ?? ""
        item.bgPath             = itemTitle.backdrop_path ?? ""
        item.posterPath         = itemTitle.poster_path ?? ""
        item.dateRelese         = itemTitle.release_date ?? ""
        item.averageVote        = itemTitle.vote_average ?? 0.0
        item.homepage           = itemTitle.homepage ?? ""
        item.runTime            = itemTitle.runtime ?? 0
        item.tagLine            = itemTitle.tagline ?? ""
        item.video              = itemTitle.video ?? false
        
        try? realm?.write {
            realm?.add(item)
        }
    }
    
    func getItems() -> [SavedItems] {
        
        var items = [SavedItems]()
        guard let itemResults = realm?.objects(SavedItems.self) else { return [] }
        for item in itemResults {
            items.append(item)
        }
        return items
    }
    
    func remove(_ itemAr: SavedItems) {

        try? realm?.write {
            realm?.delete(itemAr)
        }
    }
    
    func isMovieExist(_ itemID: Int) -> Bool {
        let result = realm?.objects(SavedItems.self).filter("id = \(String(describing: itemID))")
        if (result?.count ?? 0) > 0 {
            print("Item with ID \(String(describing: itemID)) was found.")
            return true
        } else {
            print("Item with ID \(String(describing: itemID)) was not found.")
            return false
        }
    }
    
   
    
}
