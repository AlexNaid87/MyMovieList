//
//  CreditsMovieCell.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 18.06.2022.
//

import UIKit
import SDWebImage

class CreditsMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let cornerRadius = imageView.frame.width * GlobalConstants.cornerRadiusCoef
        imageView.layer.cornerRadius = cornerRadius
    }
    
    func setupCell(item: Cast) {
        let posterPath = String(describing: item.poster_path ?? "")
        let imageUrlString = "\(GlobalConstants.picTMDBurl)\(GlobalConstants.posterSizeSmall)\(posterPath)"
        let imageUrl = URL(string: imageUrlString)
        imageView.sd_setImage(with: imageUrl,
                                placeholderImage: GlobalConstants.imagePlaceholder,
                                completed: nil)

        movieTitleLabel.text = item.title
        let releaseDate = item.release_date ?? ""
        let hyphenIndex = releaseDate.firstIndex(of: "-") ?? releaseDate.endIndex
        let year = String(releaseDate[..<hyphenIndex])
        yearLabel.text = year
    }
}
