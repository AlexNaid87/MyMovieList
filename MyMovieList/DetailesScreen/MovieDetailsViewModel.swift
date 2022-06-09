//
//  ItemDetailsViewModel.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 15.05.2022.
//

import Foundation

class MovieDetailsViewModel {
    
    static let shared = MovieDetailsViewModel()
    private init() {}
    
    var movieID: Int?
    var movie: MovieDetails?
    
    func loadMovie(completionBlock: @escaping ((MovieDetails)->())) {
        guard let movieID = movieID else { return }
        NetManager.shared.getMovieDetails(movieID: movieID) { movie in
            self.movie = movie
            completionBlock(movie)
        }
    }
}