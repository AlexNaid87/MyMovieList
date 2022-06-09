//
//  TVShowDetailsViewModel.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 18.05.2022.
//

import Foundation

class TVShowDetailsViewModel {
    
    static let shared = TVShowDetailsViewModel()
    private init() {}
    
    var tvShowID: Int?
    var tvShow: TVShowDetails?
 
    func loadTVShow(completionBlock: @escaping ((TVShowDetails)->())) {
        guard let tvShowID = tvShowID else { return }
        NetManager.shared.getTVShowDetails(tvShowID: tvShowID) { tvShow in
            self.tvShow = tvShow
            completionBlock(tvShow)
        }
    }
}
