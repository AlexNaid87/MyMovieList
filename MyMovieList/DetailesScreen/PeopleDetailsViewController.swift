//
//  PeopleDetailsViewController.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 18.05.2022.
//

import UIKit

class PeopleDetailsViewController: UIViewController {
    
    @IBOutlet weak var portretImageView: UIImageView!
    @IBOutlet weak var personNameTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var popularityTextLabel: UILabel!
    @IBOutlet weak var yearsOldAndPlaceWasBornTextLabel: UILabel!
    
    let savedMoviesVC = SavedMoviesVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cornerRadius = portretImageView.frame.height * 0.025
        portretImageView.layer.cornerRadius = cornerRadius
        
        PeopleDetailsViewModel.shared.loadPeople() { people in
            self.setUpDetails(people: people)
        }
        
    }
    
    //MARK: setup for People
    func setUpDetails(people: PeopleDetails ) {
        let personName = people.name
        personNameTextLabel.text = personName
        descriptionTextLabel.text = people.biography
        let placeHolder = #imageLiteral(resourceName: "ImageHolder")
        let profilPath = people.profile_path ?? ""
        let urlString = "\(GlobalConstants.picTMDBurl)\(GlobalConstants.posterSize)\(profilPath)"
        let imageUrl = URL(string: urlString)
        portretImageView.sd_setImage(with: imageUrl, placeholderImage: placeHolder, completed: nil)
        
        let boldText = "Popularity: "
        let fontSize = popularityTextLabel.font.pointSize
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: fontSize)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)

        let normalText = String(people.popularity ?? 0) + " of views for the day."
        let normalString = NSMutableAttributedString(string:normalText)

        attributedString.append(normalString)
        popularityTextLabel.attributedText = attributedString
        
        var birthdayStr = people.birthday ?? ""
        if let hyphenRange = birthdayStr.range(of: "-") {
            birthdayStr.removeSubrange(hyphenRange.lowerBound..<birthdayStr.endIndex)
        }
        let birthdayYear = Int(birthdayStr) ?? 0
        let thisYear = Calendar.current.component(.year, from: Date())
        let ageYaer = Int(thisYear) - birthdayYear
        let yearsOld = String(ageYaer) + " years old."
        let placeOfBorn = people.place_of_birth ?? ""
        let yearsAndPlaceString = yearsOld + " " + placeOfBorn
        yearsOldAndPlaceWasBornTextLabel.text = yearsAndPlaceString
    }
    
    
    

}
