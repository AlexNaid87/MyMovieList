//
//  MainScreenVC.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 08.05.2022.
//

import UIKit

let screenWidth   = UIScreen.main.bounds.size.width
let screenHeight  = UIScreen.main.bounds.size.height

class MainScreenVC: UIViewController {
    
    @IBOutlet weak var lastMoviesCollectionView: UICollectionView!
    @IBOutlet weak var additionalCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet var mainView: UIView!
    
    let viewModel = MainScreenViewModel.shared
    private let layout = CustomLayout()
    var itemW: CGFloat {
        return screenWidth * 0.5
    }
    var itemH: CGFloat {
        return itemW * 1.5
    }
    
    let wIndex = 0.75
    let hIndex = 1.4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(imageName: "BGFinal2.png", selectedView: view)
        setupPlaingMoviesCollectionView()
        setupAdditionalCollectionView()
    }
}

extension MainScreenVC {
    
    private func setupPlaingMoviesCollectionView() {
        lastMoviesCollectionView.backgroundColor = .clear
        lastMoviesCollectionView.decelerationRate = .fast
        lastMoviesCollectionView.showsVerticalScrollIndicator = false
        lastMoviesCollectionView.showsHorizontalScrollIndicator = false
        lastMoviesCollectionView.contentInset = UIEdgeInsets(top: 0,
                                                             left: 50,
                                                             bottom: 0,
                                                             right: 50)
        lastMoviesCollectionView.register(UINib(nibName: "LastFilmsViewCell",
                                                bundle: nil),
                                          forCellWithReuseIdentifier: "LastFilmsViewCell")
        lastMoviesCollectionView.dataSource = self
        lastMoviesCollectionView.delegate = self
        lastMoviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        lastMoviesCollectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 50.0
        layout.minimumInteritemSpacing = 50.0
        layout.itemSize.width = itemW
        
        viewModel.loadPlayinMovieList { [self] in
            pageControl.numberOfPages = viewModel.nowPlayingMovies.count
            lastMoviesCollectionView.reloadData()
            let indexPath = IndexPath(item: 1, section: 0)
            lastMoviesCollectionView.scrollToItem(at: indexPath,
                                                  at: .centeredHorizontally,
                                                  animated: true)
            layout.currentPage = indexPath.item
            layout.previosOffset = layout.updateOffset(lastMoviesCollectionView)
            
        }
    }
    
    private func setupAdditionalCollectionView() {
        additionalCollectionView.register(UINib(nibName: "AdditionalMoviesCell", bundle: nil), forCellWithReuseIdentifier: "AdditionalMoviesCell")
        additionalCollectionView.dataSource = self
        additionalCollectionView.delegate = self
        additionalCollectionView.backgroundColor = .clear
        viewModel.loadTopRatedMovieList {
            self.additionalCollectionView.reloadData()
        }
    }
}


//      MARK: All CollectionView settings 

extension MainScreenVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == lastMoviesCollectionView {
            return viewModel.nowPlayingMovies.count
        } else {
            return viewModel.topRatedMovies.count
        }
    }
    
    // MARK: Setuping the cell content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == lastMoviesCollectionView {
            let cell = lastMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: "LastFilmsViewCell", for: indexPath) as! LastFilmsViewCell
            let cellData = viewModel.nowPlayingMovies[indexPath.item]
            cell.setupCellLastMovies(item: cellData)
            return cell
        } else {
            let cell = additionalCollectionView.dequeueReusableCell(withReuseIdentifier: "AdditionalMoviesCell", for: indexPath) as! AdditionalMoviesCell
            let cellData = viewModel.topRatedMovies[indexPath.item]
            cell.setupLatestMoviesCell(item: cellData)
            return cell
        }
    }
}


extension MainScreenVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == lastMoviesCollectionView {
            if indexPath.item != layout.currentPage {
                lastMoviesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                layout.currentPage = indexPath.item
                layout.previosOffset = layout.updateOffset(lastMoviesCollectionView)
            } else {
                let storyboard = UIStoryboard(name:"Main", bundle: nil)
                guard let vc = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
                MovieDetailsViewModel.shared.movieID = viewModel.nowPlayingMovies[indexPath.item].id!
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let storyboard = UIStoryboard(name:"Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
            MovieDetailsViewModel.shared.movieID = viewModel.topRatedMovies[indexPath.item].id!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == lastMoviesCollectionView {
            pageControl.currentPage = indexPath.item
        } else { return }
        
    }
}

extension MainScreenVC: UICollectionViewDelegateFlowLayout {
    
    // MARK: Define size of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == lastMoviesCollectionView {
            return CGSize(width: itemW, height: itemH)
        } else {
            let cellw: Int = Int(screenWidth * 0.275)
            let cellh: Int = cellw / 2 * 3
            return CGSize(width: cellw, height: cellh)
        }
    }
    
    
    
    // MARK: Spacing boaders for lastMoviesCollectionView from all sides
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == additionalCollectionView {
            let leftRightSpace = (screenWidth - (screenWidth * 0.95))
            return UIEdgeInsets(top: 0, left: leftRightSpace, bottom: 0, right: leftRightSpace)
        } else { return UIEdgeInsets()}
    }
    
}

// MARK: UIScrollViewDelegate

extension MainScreenVC {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("ScrollViewDidEndScrollingAnimation was working")
        setupCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            setupCell()
        }
    }
    
    private func setupCell() {
        let indexPath = IndexPath(item: layout.currentPage, section: 0)
        if let cell = lastMoviesCollectionView.cellForItem(at: indexPath) {
            transformCell(cell)
        }
    }
    
    private func transformCell(_ cell: UICollectionViewCell, isEffect: Bool = true) {
        if !isEffect {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            return
        }
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        for otherCell in lastMoviesCollectionView.visibleCells {
            if let indexPath = lastMoviesCollectionView.indexPath(for: otherCell) {
                if indexPath.item != layout.currentPage {
                    UIView.animate(withDuration: 0.2) {
                        otherCell.transform = .identity
                    }
                }
            }
        }
    }
}



