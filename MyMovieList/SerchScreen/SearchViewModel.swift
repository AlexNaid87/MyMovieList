//
//  SerchViewModel.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 15.05.2022.
//

import Foundation

class SearchViewModel {
    
    static let shared = SearchViewModel()
    
    var movieList: [Movie] = []
    var tvShowList: [TVShow] = []
    var peopleList: [People] = []
    
    var word: String?
    var searchedMoviesList: [Movie] = []

    func loadMovieList(segmentedControl: Int, completion: @escaping (()->())) {
        switch segmentedControl {
        case 0:
            NetManager().getPopularMovies(completion: { items in
                self.movieList = items
                completion()
            })
        case 1:
            NetManager().getTVShows(completion: { items in
                self.tvShowList = items
                completion()
            })
        default:
            NetManager().getPeople(completion: { items in
                self.peopleList = items
                completion()
            })
        }
    }
    
    func loadSearchedList(segmentedControl: Int, completion: @escaping (()->())) {
        guard let word = word else { return }
        let fixedWord = word.replacingOccurrences(of: " ", with: "%20")
        switch segmentedControl {
        case 1:
            NetManager().getSearchedTVShows(word: fixedWord) { tvShow in
                self.tvShowList = tvShow
                completion()
            }
        case 2:
            NetManager().getSearchedPeople(word: fixedWord) { people in
            self.peopleList = people
            completion()
        }
        default:
            NetManager().getSearchedMovies(word: fixedWord) { movie in
                self.movieList = movie
                completion()
            }
        }
    }
}

