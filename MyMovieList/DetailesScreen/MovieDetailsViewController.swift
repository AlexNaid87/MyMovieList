//
//  DetailsViewController.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 03.05.2022.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper_swift
import Cosmos
import SwiftUI

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var bgPosterImage: UIImageView!
    @IBOutlet weak var mainPosterImage: UIImageView!
    @IBOutlet weak var mainTitleTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var watchTrailerButton: UIButton!
    @IBOutlet weak var ytPlayer: YTPlayerView!
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var yearActionDurationTextLabel: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var contentViewScroll: UIView!
    
    let savedMoviesVC = SavedMoviesVC()
    private var gradient: CAGradientLayer!
    let viewModel = MovieDetailsViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(imageName: "BGFinal2.png", selectedView: view)
        updateNavBar()
        self.ytPlayer.isHidden = true
        viewModel.loadMovie() { movie in
            self.setUpDeteils(movie: movie)
        }
    }
    
    
    
    //  MARK: setup for movies:
    func setUpDeteils(movie: MovieDetails ) {
        let mainMovieTitle = movie.title
        mainTitleTextLabel.text = mainMovieTitle
        descriptionTextLabel.text = movie.overview
        
        let releaseDate = movie.release_date ?? ""
        let hyphenIndex = releaseDate.firstIndex(of: "-") ?? releaseDate.endIndex
        let year = String(releaseDate[..<hyphenIndex])
        guard let genresArr = movie.genres else { return }
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
        
        let durationText = viewModel.getTimeDuration(runtime: movie.runtime ?? 0)
        let yearActionDurationText = year + " • " + actionType + " • " + durationText
        yearActionDurationTextLabel.text = yearActionDurationText
        
        let voteAverage = movie.vote_average ?? 0.0
        
        starRatingView.rating = voteAverage / 2
        starRatingView.text = String(voteAverage)
        
        let pictureWeight = 500
        let picTMDBurl = "https://image.tmdb.org/t/p/w"
        let placeHolder = #imageLiteral(resourceName: "ImageHolder")
        let bgPath = movie.backdrop_path ?? ""
        
        let bgImageUrlString = "\(picTMDBurl)\(pictureWeight)/\(bgPath)"
        let bgImageUrl = URL(string: bgImageUrlString)
        bgPosterImage.sd_setImage(with: bgImageUrl, placeholderImage: placeHolder, completed: nil)
        bgPosterImage.applyBlurEffect()
        makeFadeOutMask(imageLayer: bgPosterImage)
        
        let posterPath = movie.poster_path ?? ""
        let imageUrlString = "\(picTMDBurl)\(pictureWeight)/\(posterPath)"
        let imageUrl = URL(string: imageUrlString)
        mainPosterImage.sd_setImage(with: imageUrl, placeholderImage: placeHolder, completed: nil)
        let cornerRadius = mainPosterImage.frame.height * 0.025
        mainPosterImage.layer.cornerRadius = cornerRadius
    }
    
    //  MARK: Actions
    @IBAction func watchTrailerButtonPressed(_ sender: Any) {
        guard let movieID = MovieDetailsViewModel.shared.movieID else { return }
        NetManager().getMovieVideo(movieID: movieID) { video in
            guard let keyCode = video[0].key else { return }
            self.ytPlayer.isHidden = false
            self.ytPlayer.load(videoId: keyCode)
        }
    }
    
    @IBAction func addToListButtonPressed(_ sender: Any) {
        let movieID = MovieDetailsViewModel.shared.movieID
        print("Try to check movie with id: \(movieID!)")
        if DataManager.shared.isMovieExist(movieID!) != true {
            guard let movieArray = MovieDetailsViewModel.shared.movie else { return }
            DataManager.shared.save(movieArray)
            displayAlert(message: "The Movie was added in list.")
        } else {
            displayAlert(message: "This Movie is already in list.")
            print("Film with ID \(String(describing: movieID!)) already exist in list")
            return
        }
    }
    
    private func makeFadeOutMask(imageLayer: UIImageView) {
        let gradient = CAGradientLayer()
        gradient.frame = imageLayer.bounds
        gradient.colors = [UIColor.black.cgColor,
                           UIColor.clear.cgColor]
        gradient.locations = [0.5, 0.9]
        imageLayer.layer.mask = gradient
    }
    
    private func displayAlert(message: String) {
        let alert = UIAlertController(title: "",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
}






