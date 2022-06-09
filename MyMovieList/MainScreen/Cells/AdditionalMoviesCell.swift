//
//  AdditionalMoviesCell.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 09.05.2022.
//

import UIKit
import SDWebImage

class AdditionalMoviesCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let cornerRadius = posterImage.frame.width * 0.1
        posterImage.layer.cornerRadius = cornerRadius
        
    }
    
    func setupLatestMoviesCell(item: Movie) {
        let placeHolder = #imageLiteral(resourceName: "ImageHolder")
        let posterPath = String(describing: item.poster_path ?? "")
        let posterWeight = 400
        let imageUrlString = "https://image.tmdb.org/t/p/w\(posterWeight)/\(posterPath)"
        let imageUrl = URL(string: imageUrlString)
        posterImage.sd_setImage(with: imageUrl, placeholderImage: placeHolder, completed: nil)
    }

}
