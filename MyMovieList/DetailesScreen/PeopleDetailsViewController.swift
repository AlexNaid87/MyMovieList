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
    @IBOutlet weak var birthDayTextLabel: UILabel!
    @IBOutlet weak var ageTextLabel: UILabel!
    @IBOutlet weak var fromTextLabel: UILabel!
    @IBOutlet weak var popularityTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var creditsCollectionView: UICollectionView!
    @IBOutlet weak var heighConstrain: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let viewModel = PeopleDetailsViewModel.shared
    let savedMoviesVC = SavedMoviesVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavBar()
        setBackgroundImage(imageName: "BGFinal2.png", selectedView: view)
        
//        let heightContentView = descriptionTextLabel.frame.height + 850
//        heighConstrain.constant = heightContentView
        viewModel.loadPeople() { people in
                    self.setUpDetails(people: people)
                }
        creditsCollectionView.register(UINib(nibName: "CreditsMovieCell", bundle: nil), forCellWithReuseIdentifier: "CreditsMovieCell")
        creditsCollectionView.dataSource = self
        creditsCollectionView.delegate = self
        
        viewModel.loadMovieCredits(completion: {
            self.creditsCollectionView.reloadData()
        })
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
//            rect = rect.union(view.frame)
//        }
//        scrollView.contentSize = contentRect.size
//    }
    
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
        let cornerRadius = portretImageView.frame.height * 0.025
        portretImageView.layer.cornerRadius = cornerRadius
        
        // Set Popularity text
        let popularityText = String(people.popularity ?? 0) + " of views for the day."
        makeBoldPartText(boldText: "Popularity: ",
                         normalText: popularityText,
                         label: popularityTextLabel)
        
        // Set BirthDay text
        var birthdayStr = people.birthday ?? ""
        makeBoldPartText(boldText: "Bithday: ", normalText: birthdayStr, label: birthDayTextLabel)
        
        // Set Age text
        if let hyphenRange = birthdayStr.range(of: "-") {
            birthdayStr.removeSubrange(hyphenRange.lowerBound..<birthdayStr.endIndex)
        }
        let birthdayYear = Int(birthdayStr) ?? 0
        let thisYear = Calendar.current.component(.year, from: Date())
        let ageYaer = Int(thisYear) - birthdayYear
        let yearsOld = String(ageYaer) + " years old."
        makeBoldPartText(boldText: "Age: ", normalText: yearsOld, label: ageTextLabel)
        
        // Set Place from Text
        let placeOfBorn = people.place_of_birth ?? ""
        makeBoldPartText(boldText: "From: ", normalText: placeOfBorn, label: fromTextLabel)
        

    }
    
    
    private func makeFadeOutMask(imageLayer: UIImageView) {
        let gradient = CAGradientLayer()
        gradient.frame = imageLayer.bounds
        gradient.colors = [UIColor.black.cgColor,
                           UIColor.clear.cgColor]
        gradient.locations = [0.5, 0.9]
        imageLayer.layer.mask = gradient
    }
    
    private func makeBoldPartText(boldText: String, normalText: String, label: UILabel) {
        let fontSize = label.font.pointSize
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: fontSize)]
        let attributedString = NSMutableAttributedString(string: boldText, attributes: attrs)
        let normalString = NSMutableAttributedString(string: normalText)
        attributedString.append(normalString)
        label.attributedText = attributedString
    }

}

extension PeopleDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = creditsCollectionView.dequeueReusableCell(withReuseIdentifier: "CreditsMovieCell", for: indexPath) as! CreditsMovieCell
        let cellData = viewModel.cast[indexPath.row]
        cell.setupCell(item: cellData)
        return cell
    }
}

extension PeopleDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item was selected")
    }
}
    
    

extension PeopleDetailsViewController: UICollectionViewDelegateFlowLayout {
    //MARK: Size of cells
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = screenWidth * 0.25
        let height = width / 2 * 4
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightSpace = (screenWidth * 0.095) / 2
        return UIEdgeInsets(top: 0, left: leftRightSpace, bottom: 0, right: leftRightSpace)
    }
    
    //MARK: minimumLineSpacingForSectionAt method:
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let spaceToSide = screenWidth * 0.095 / 2
        return spaceToSide
    }
    
    //MARK: minimumInteritemSpacingForSectionAt method:
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
