//
//  TVShowDetailsViewController.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 18.05.2022.
//

import UIKit
import Cosmos

class TVShowDetailsViewController: UIViewController {

    
    @IBOutlet weak var originalNameTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var yearActionDurationTextLabel: UILabel!
    @IBOutlet weak var starRatingView: CosmosView!
    
    
    let savedMoviesVC = SavedMoviesVC()
    var viewModel = TVShowDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavBar()
        setBackgroundImage(selectedView: view)
        viewModel.loadTVShow() { tvShow in
            self.setUpDeteils(tvShow: tvShow)
        }
     
    }
    
//  MARK: setup for TVShows
    func setUpDeteils(tvShow: TVShowDetails ) {
        let originalTitle = tvShow.original_name
        originalNameTextLabel.text = originalTitle
        descriptionTextLabel.text = tvShow.overview
        
        let releaseDate = tvShow.first_air_date ?? ""
        let hyphenIndex = releaseDate.firstIndex(of: "-") ?? releaseDate.endIndex
        let year = String(releaseDate[..<hyphenIndex])
        guard let genresArr = tvShow.genres else { return }
        var actions: String = ""
        if genresArr.count > 2 {
            for i in 1...2 {
                actions = actions + (genresArr[i].name ?? "") + ", "
            }
        } else {
            genresArr.forEach({ item in
                actions = actions + (item.name ?? "") + ", "
            })
        }
        let actionType = actions.dropLast(2)
        guard let durationText = tvShow.episode_run_time?[0] else { return }
        let yearActionDurationText = "\(year) • \(actionType) • \(String(describing: durationText)) min"
        yearActionDurationTextLabel.text = yearActionDurationText
        
        let voteAverage = tvShow.vote_average ?? 0
        starRatingView.rating = voteAverage / 2
        starRatingView.text = String(voteAverage)
        
        let pictureWeight = 500
        let picTMDBurl = "https://image.tmdb.org/t/p/w"
        let placeHolder = #imageLiteral(resourceName: "ImageHolder")
        let bgPath = tvShow.backdrop_path ?? ""
        
        let bgImageUrlString = "\(picTMDBurl)\(pictureWeight)/\(bgPath)"
        let bgImageUrl = URL(string: bgImageUrlString)
        bgImageView.sd_setImage(with: bgImageUrl, placeholderImage: placeHolder, completed: nil)
        bgImageView.applyBlurEffect()
        makeFadeOutMask(imageLayer: bgImageView)

        let posterPath = tvShow.poster_path ?? ""
        let imageUrlString = "\(picTMDBurl)\(pictureWeight)/\(posterPath)"
        let imageUrl = URL(string: imageUrlString)
        posterImageView.sd_setImage(with: imageUrl, placeholderImage: placeHolder, completed: nil)
        // Add to constants or add comment
        let cornerRadius = posterImageView.frame.height * 0.025
        posterImageView.layer.cornerRadius = cornerRadius
        
    }
    
    private func makeFadeOutMask(imageLayer: UIImageView) {
        let gradient = CAGradientLayer()
        gradient.frame = imageLayer.bounds
        gradient.colors = [UIColor.black.cgColor,
                           UIColor.clear.cgColor]
        gradient.locations = [0.5, 0.9]
        imageLayer.layer.mask = gradient
    }

}
