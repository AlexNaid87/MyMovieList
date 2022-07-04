//
//  SavedMoviesViewModel.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 18.05.2022.
//

import Foundation

class SavedMoviesViewModel {
    
    var savedItems: [SavedItems] = []
    var movieID: Int?
    
    func loadSavedMovieList(completion: (()->())) {
        savedItems = DataManager().getItems()
        completion()
    }
}
