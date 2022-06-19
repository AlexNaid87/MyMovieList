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
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let cornerRadius = mainView.frame.height * 0.05
        mainView.layer.cornerRadius = cornerRadius
        mainView.backgroundColor = UIColor(white: 1, alpha: 0.1)
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
        
        mainTitleTextLabel.text = item.title
        tagLineTextLabel.text = item.tagLine
        let voteAverage = item.averageVote
        voteTextLabel.text = "\(String(voteAverage))"
        
        let movieType = item.genres
        movieTypeLabel.text = movieType
        
        let durationText = getDuration(runtime: item.runTime )
        durationLabel.text = durationText
        
        
    }
    
    private func getDuration(runtime: Int) -> String {
        let hours = runtime / 60
        let minutes = runtime - (hours * 60)
        let result: String = String(hours) + " h " + String(minutes) + " min"
        return result
    }
}


