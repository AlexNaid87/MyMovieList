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
        
        
        
    }

    func setupCellLastMovies(item: Movie) {
        let placeHolder = GlobalConstants.imagePlaceholder
        guard let posterPath = item.poster_path else { return }
        let posterWeight = String(describing: GlobalConstants.posterSize)
        let imageUrlString = GlobalConstants.picTMDBurl + posterWeight + "/" + posterPath
        let imageUrl = URL(string: imageUrlString)
        posterImageView.sd_setImage(with: imageUrl, placeholderImage: placeHolder, completed: nil)
        let cornerRadius = posterImageView.frame.height * GlobalConstants.cornerRadiusCoef
        posterImageView.layer.cornerRadius = cornerRadius
    }
}
