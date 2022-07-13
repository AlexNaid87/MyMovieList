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
        
    }
    
    func setupLatestMoviesCell(item: Movie) {
        let placeHolder = GlobalConstants.imagePlaceholder
        guard let posterPath = item.poster_path else { return }
        let posterWeight = String(describing: GlobalConstants.posterSize)
        let imageUrlString = GlobalConstants.picTMDBurl + posterWeight + "/" + posterPath
        let imageUrl = URL(string: imageUrlString)
        posterImage.sd_setImage(with: imageUrl, placeholderImage: placeHolder, completed: nil)
        let cornerRadius = posterImage.frame.width * GlobalConstants.cornerRadiusCoef
        posterImage.layer.cornerRadius = cornerRadius
    }

}
