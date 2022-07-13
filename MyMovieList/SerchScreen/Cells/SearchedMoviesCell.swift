//
//  SearchedMoviesCell.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 02.05.2022.
//

import UIKit
import SDWebImage

class SearchedMoviesCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleMovieLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let cornerRadius = posterImage.frame.height * 0.025
        posterImage.layer.cornerRadius = cornerRadius
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
    }
    
    func setupCell(item: Movie) {
        let placeHolder = #imageLiteral(resourceName: "ImageHolder")
        let posterPath = String(describing: item.poster_path ?? "")
        let posterWeight = 200
        let imageUrlString = "https://image.tmdb.org/t/p/w\(posterWeight)/\(posterPath)"
        let imageUrl = URL(string: imageUrlString)
        posterImage.sd_setImage(with: imageUrl, placeholderImage: placeHolder, completed: nil)
    }
    
    func setupCell(item: TVShow) {
        let placeHolder = #imageLiteral(resourceName: "ImageHolder")
        let posterPath = String(describing: item.poster_path ?? "")
        let posterWeight = 200
        let imageUrlString = "https://image.tmdb.org/t/p/w\(posterWeight)/\(posterPath)"
        let imageUrl = URL(string: imageUrlString)
        posterImage.sd_setImage(with: imageUrl, placeholderImage: placeHolder, completed: nil)
    }
    
    func setupCell(item: People) {
        let placeHolder = #imageLiteral(resourceName: "ImageHolder")
        let posterPath = String(describing: item.profile_path ?? "")
        let posterWeight = 200
        let imageUrlString = "https://image.tmdb.org/t/p/w\(posterWeight)/\(posterPath)"
        let imageUrl = URL(string: imageUrlString)
        posterImage.sd_setImage(with: imageUrl, placeholderImage: placeHolder, completed: nil)
    }

}
