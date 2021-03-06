//
//  MainScreenViewModel.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 21.05.2022.
//

import Foundation
import UIKit

class MainScreenViewModel {
        
    var nowPlayingMovies: [Movie] = []
    var topRatedMovies: [Movie] = []
    
    func loadPlayinMovieList(completion: @escaping (()->())) {
        NetManager().getNowPlayingMovies(completion: { movie in
            self.nowPlayingMovies = movie
            completion()
        })
    }
    
    func loadTopRatedMovieList(completion: @escaping (()->())) {
        NetManager().getTopRatedMovies(completion: { movie in
            self.topRatedMovies = movie
            completion()
        })
    }    
}
