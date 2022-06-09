//
//  PeopleDetailsViewController.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 18.05.2022.
//

import UIKit

class PeopleDetailsViewController: UIViewController {
    
    @IBOutlet weak var portretImageView: UIImageView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var personNameTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    
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
        bgImageView.sd_setImage(with: imageUrl, placeholderImage: placeHolder, completed: nil)
        bgImageView.applyBlurEffect()
        
        portretImageView.sd_setImage(with: imageUrl, placeholderImage: placeHolder, completed: nil)
    }
    
    

}
