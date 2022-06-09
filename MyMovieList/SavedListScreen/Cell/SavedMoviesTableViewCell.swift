//
//  SavedMoviesTableViewCell.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 03.05.2022.
//

import UIKit
import SDWebImage

class SavedMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var mainTitleTextLabel: UILabel!
    @IBOutlet weak var voteTextLabel: UILabel!
    @IBOutlet weak var tagLineTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cornerRadius = mainView.frame.height * 0.05
        mainView.layer.cornerRadius = cornerRadius
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func alreadySawButtonPressed(_ sender: Any) {
        
    }
    
    func setupSavedMoviesCell(item: SavedItems) {
        let posterPath = String(describing: item.posterPath)
        let imageUrlString = "\(GlobalConstants.picTMDBurl)\(GlobalConstants.posterSizeSmall)/\(posterPath)"
        let imageUrl = URL(string: imageUrlString)
        posterImage.sd_setImage(with: imageUrl,
                                placeholderImage: GlobalConstants.imagePlaceholder,
                                completed: nil)
        let mainTitle = item.title
        mainTitleTextLabel.text = mainTitle
        if mainTitleTextLabel.numberOfLines > 1 {
            tagLineTextLabel.numberOfLines = 1
        }
        tagLineTextLabel.text = item.tagLine
        let voteAverage = item.averageVote
        voteTextLabel.text = "\(String(voteAverage))"
    }
}


