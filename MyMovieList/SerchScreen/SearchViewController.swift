//
//  SearchViewController.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 02.05.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchedMoviesCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var typeContentSegmentedControl: UISegmentedControl!
    
    let screenWidth = UIScreen.main.bounds.width
    var typeContent: Int?
    let viewModel = SearchViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavBar()
        setBackgroundImage(imageName: "BGFinal2.png", selectedView: view)
        searchedMoviesCollectionView.register(UINib(nibName: "SearchedMoviesCell", bundle: nil), forCellWithReuseIdentifier: "SearchedMoviesCell")
        searchedMoviesCollectionView.dataSource = self
        searchedMoviesCollectionView.delegate = self
        
        let index = typeContentSegmentedControl.selectedSegmentIndex
        viewModel.loadMovieList(segmentedControl: index) {
            self.searchedMoviesCollectionView.reloadData()
        }
        typeContentSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        typeContentSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: UIControl.State.normal)

        searchBar.delegate = self
        searchBar.searchTextField.textColor = UIColor.white

        
        
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        let index = typeContentSegmentedControl.selectedSegmentIndex
        viewModel.loadMovieList(segmentedControl: index) {
            self.searchedMoviesCollectionView.reloadData()
        }
    }
}



// MARK: All CollectionView settings for SearchScreen ViewController
// MARK: UICollectionViewDataSourse methods:
extension SearchViewController: UICollectionViewDataSource {
    
    // MARK: numberOfItemsInSection method:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch typeContentSegmentedControl.selectedSegmentIndex {
        case 0: return viewModel.movieList.count
        case 1: return viewModel.tvShowList.count
        default: return viewModel.peopleList.count
        }
        
    }
    // MARK: cellForItemAt method:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchedMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchedMoviesCell",
                                                                    for: indexPath) as! SearchedMoviesCell
        
        switch typeContentSegmentedControl.selectedSegmentIndex {
        case 0:
            let cellData = viewModel.movieList[indexPath.row]
            cell.setupCell(item: cellData)
            return cell
        case 1:
            let cellData = viewModel.tvShowList[indexPath.row]
            cell.setupCell(item: cellData)
            return cell
        default:
            let cellData = viewModel.peopleList[indexPath.row]
            cell.setupCell(item: cellData)
            return cell
            
        }
        
    }
}

// MARK: UICollectionViewDelegate methods:
extension SearchViewController: UICollectionViewDelegate {
    
    // MARK: didSelectItemAt method:
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let index = typeContentSegmentedControl.selectedSegmentIndex
        switch index {
        case 1:
            guard let vc = storyboard.instantiateViewController(identifier: "TVShowDetailsViewController") as? TVShowDetailsViewController else { return }
            TVShowDetailsViewModel.shared.tvShowID = viewModel.tvShowList[indexPath.row].id!
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            guard let vc = storyboard.instantiateViewController(identifier: "PeopleDetailsViewController") as? PeopleDetailsViewController else { return }
            PeopleDetailsViewModel.shared.peopleID = viewModel.peopleList[indexPath.row].id!
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            guard let vc = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
            MovieDetailsViewModel.shared.movieID = viewModel.movieList[indexPath.row].id!
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        
        
        
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout methods:
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    //MARK: Size of cells
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = screenWidth * 0.275
        let height = width / 2 * 3
        return CGSize(width: width, height: height)
    }
    
    //MARK: insetForSectionAt method
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


extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let index = typeContentSegmentedControl.selectedSegmentIndex
        if searchText == "" {
            viewModel.loadMovieList(segmentedControl: index) {
                self.searchedMoviesCollectionView.reloadData()
            }
        } else {
            viewModel.word = searchText
            viewModel.loadSearchedList(segmentedControl: index) {
                self.searchedMoviesCollectionView.reloadData()
            }
        }
    }
}

