//
//  MainScreenVC.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 08.05.2022.
//

import UIKit

class MainScreenVC: UIViewController {
    
    @IBOutlet weak var lastMoviesCollectionView: UICollectionView!
    @IBOutlet weak var additionalCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let viewModel = MainScreenViewModel()
    private let layout = CustomLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(selectedView: view)
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
        let padding = CGFloat(GlobalConstants.padding)
        lastMoviesCollectionView.contentInset = UIEdgeInsets(top: 0,
                                                             left: padding,
                                                             bottom: 0,
                                                             right: padding)
        lastMoviesCollectionView.registerCellWithNib(cellClass: LastFilmsViewCell.self)
        lastMoviesCollectionView.dataSource = self
        lastMoviesCollectionView.delegate = self
        lastMoviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        lastMoviesCollectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        layout.itemSize.width = GlobalConstants.itemW
        
        viewModel.loadPlayinMovieList { [self] in
            lastMoviesCollectionView.reloadData()
            pageControl.numberOfPages = (viewModel.nowPlayingMovies.count)
            let indexPath = IndexPath(item: 1, section: 0)
            lastMoviesCollectionView.scrollToItem(at: indexPath,
                                                  at: .centeredHorizontally,
                                                  animated: true)
            layout.currentPage = indexPath.item
            layout.previosOffset = (layout.updateOffset(lastMoviesCollectionView))
        }
    }
    
    private func setupAdditionalCollectionView() {
        additionalCollectionView.registerCellWithNib(cellClass: AdditionalMoviesCell.self)
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
        switch collectionView {
        case lastMoviesCollectionView:
            return viewModel.nowPlayingMovies.count
        case additionalCollectionView:
            return viewModel.topRatedMovies.count
        default: return 0
        }
        
    }
    
    // MARK: Setuping the cell content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case lastMoviesCollectionView:
            let cell: LastFilmsViewCell = lastMoviesCollectionView.dequeueReusableCell(for: indexPath)
            let cellData = viewModel.nowPlayingMovies[indexPath.item]
            cell.setupCellLastMovies(item: cellData)
            return cell
        case additionalCollectionView:
            let cell: AdditionalMoviesCell = additionalCollectionView.dequeueReusableCell(for: indexPath)
            let cellData = viewModel.topRatedMovies[indexPath.item]
            cell.setupLatestMoviesCell(item: cellData)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}


extension MainScreenVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModelDetails = MovieDetailsViewModel()
        switch collectionView {
        case lastMoviesCollectionView:
//            pageControl.currentPage = indexPath.item
            if indexPath.item != layout.currentPage {
                lastMoviesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                layout.currentPage = indexPath.item
                layout.previosOffset = layout.updateOffset(lastMoviesCollectionView)
            } else {
                let storyboard = UIStoryboard(name:"Main", bundle: nil)
                guard let vc = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
                viewModelDetails.movieID = viewModel.nowPlayingMovies[indexPath.item].id!
                vc.viewModel = viewModelDetails
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case additionalCollectionView:
            let storyboard = UIStoryboard(name:"Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
            viewModelDetails.movieID = viewModel.topRatedMovies[indexPath.item].id!
            vc.viewModel = viewModelDetails
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
        
    }
    
//        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//            if collectionView == lastMoviesCollectionView {
//                pageControl.currentPage = indexPath.
//                print(pageControl.currentPage)
//            } else { return }
//        }
   
    // DIDDISPLAY
    // SCROLLVIEW DID END
}

extension MainScreenVC: UICollectionViewDelegateFlowLayout {
    
    // MARK: Define size of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == lastMoviesCollectionView {
            return CGSize(width: GlobalConstants.itemW,
                          height: GlobalConstants.itemH)
        } else {
            let cellw: Int = Int(GlobalConstants.screenWidth * 0.275)
            let cellh: Int = cellw / 2 * 3
            return CGSize(width: cellw, height: cellh)
        }
    }
    
    
    
    // MARK: Spacing boaders for lastMoviesCollectionView from all sides
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == additionalCollectionView {
            let padding = (GlobalConstants.screenWidth - GlobalConstants.screenWidthMinusPadding)
            return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        } else { return UIEdgeInsets()}
    }
    
}

// MARK: UIScrollViewDelegate

extension MainScreenVC {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
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
        pageControl.currentPage = indexPath.row
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





