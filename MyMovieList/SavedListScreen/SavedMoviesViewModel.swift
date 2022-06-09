//
//  SavedMoviesViewModel.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 18.05.2022.
//

import Foundation

class SavedMoviesViewModel {
    
    static let shared = SavedMoviesViewModel()
    private init() {}
    
    var savedItems: [SavedItems] = []
    var movieID: Int?
    
    func loadSavedMovieList(completion: (()->())) {
        savedItems = DataManager.shared.getItems()
        completion()
    }
}
