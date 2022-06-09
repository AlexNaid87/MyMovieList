//
//  TVShowDetailsViewController.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 18.05.2022.
//

import UIKit

class TVShowDetailsViewController: UIViewController {

    
    @IBOutlet weak var originalNameTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingTextLabel: UILabel!
    @IBOutlet weak var dateInAirTextLabel: UILabel!
    @IBOutlet weak var genresTextLable: UILabel!
    
    let savedMoviesVC = SavedMoviesVC()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cornerRadius = posterImageView.frame.height * 0.025
        posterImageView.layer.cornerRadius = cornerRadius
        
        TVShowDetailsViewModel.shared.loadTVShow() { tvShow in
            self.setUpDeteils(tvShow: tvShow)
        }
     
    }
    
    //MARK: setup for TVShows
    func setUpDeteils(tvShow: TVShowDetails ) {
        let originalTitle = tvShow.original_name
        originalNameTextLabel.text = originalTitle
        descriptionTextLabel.text = tvShow.overview
        
        let releaseDate = tvShow.first_air_date ?? ""
        let hyphenIndex = releaseDate.firstIndex(of: "-") ?? releaseDate.endIndex
        let year = releaseDate[..<hyphenIndex]
        dateInAirTextLabel.text = String(year)
        
        let voteAverage = tvShow.vote_average ?? 0.0
        ratingTextLabel.text = "\(String(voteAverage)) из 10"
        
        let pictureWeight = 500
        let picTMDBurl = "https://image.tmdb.org/t/p/w"
        let placeHolder = #imageLiteral(resourceName: "ImageHolder")
        let bgPath = tvShow.backdrop_path ?? ""
        
        let bgImageUrlString = "\(picTMDBurl)\(pictureWeight)/\(bgPath)"
        let bgImageUrl = URL(string: bgImageUrlString)
        bgImageView.sd_setImage(with: bgImageUrl, placeholderImage: placeHolder, completed: nil)
        bgImageView.applyBlurEffect()
        
        let posterPath = tvShow.poster_path ?? ""
        let imageUrlString = "\(picTMDBurl)\(pictureWeight)/\(posterPath)"
        let imageUrl = URL(string: imageUrlString)
        posterImageView.sd_setImage(with: imageUrl, placeholderImage: placeHolder, completed: nil)
    }

}
