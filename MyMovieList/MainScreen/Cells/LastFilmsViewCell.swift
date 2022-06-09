//
//  LastFilmsViewCell.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 08.05.2022.
//

import UIKit
import SDWebImage

class LastFilmsViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cornerRadius = posterImageView.frame.height * 0.05
        posterImageView.layer.cornerRadius = cornerRadius
        
    }

    
    func setupCellLastMovies(item: Movie) {
       
        let placeHolder = #imageLiteral(resourceName: "ImageHolder")
        let posterPath = String(describing: item.poster_path ?? "")
        let posterWeight = 400
        let imageUrlString = "https://image.tmdb.org/t/p/w\(posterWeight)/\(posterPath)"
        let imageUrl = URL(string: imageUrlString)
        posterImageView.sd_setImage(with: imageUrl, placeholderImage: placeHolder, completed: nil)
    }
}
