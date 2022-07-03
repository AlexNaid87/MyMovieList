//
//  TVShowDetailsViewModel.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 18.05.2022.
//

import Foundation

class TVShowDetailsViewModel {

    var tvShowID: Int?
    var tvShow: TVShowDetails?
 
    func loadTVShow(completionBlock: @escaping ((TVShowDetails)->())) {
        guard let tvShowID = tvShowID else { return }
        NetManager().getTVShowDetails(tvShowID: tvShowID) { tvShow in
            self.tvShow = tvShow
            completionBlock(tvShow)
        }
    }
}
