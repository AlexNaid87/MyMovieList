//
//  MainScreenViewModel.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 21.05.2022.
//

import Foundation
import UIKit

class MainScreenViewModel {
    
    static let shared = MainScreenViewModel()
    private init() {}
    
    var nowPlayingMovies: [Movie] = []
    var topRatedMovies: [Movie] = []
    
    func loadPlayinMovieList(completion: @escaping (()->())) {
        NetManager.shared.getNowPlayingMovies(completion: { movie in
            self.nowPlayingMovies = movie
            completion()
        })
    }
    
    func loadTopRatedMovieList(completion: @escaping (()->())) {
        NetManager.shared.getTopRatedMovies(completion: { movie in
            self.topRatedMovies = movie
            completion()
        })
    }    
}
