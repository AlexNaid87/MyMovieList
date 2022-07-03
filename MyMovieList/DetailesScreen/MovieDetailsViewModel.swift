//
//  ItemDetailsViewModel.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 15.05.2022.
//

import Foundation
import SwiftUI

class MovieDetailsViewModel {
    
    var movieID: Int?
    var movie: MovieDetails?
    
    func setMovieID(movieID: Int) {
        self.movieID = movieID
    }
    
    func loadMovie(completionBlock: @escaping ((MovieDetails)->())) {
        guard let movieID = movieID else { return }
        NetManager().getMovieDetails(movieID: movieID) { movie in
            self.movie = movie
            completionBlock(movie)
        }
    }
    
    func getTimeDuration(runtime: Int) -> String {
        let hours = runtime / 60
        let minutes = runtime - (hours * 60)
        let result: String = String(hours) + " h " + String(minutes) + " min"
        return result
    }
}


class Dynamic<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
