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
    
    // MARK: - VIEWCONTROLLER LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(selectedView: view)
        setupPlaingMoviesCollectionView()
        setupAdditionalCollectionView()
        loadData()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        resizeCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            resizeCell()
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    private func loadData() {
        
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
        
        viewModel.loadTopRatedMovieList {
            self.additionalCollectionView.reloadData()
        }
    }
    
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
        lastMoviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        lastMoviesCollectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        layout.itemSize.width = GlobalConstants.itemW
    }
    
    private func setupAdditionalCollectionView() {
        additionalCollectionView.registerCellWithNib(cellClass: AdditionalMoviesCell.self)
        additionalCollectionView.backgroundColor = .clear
        
    }
    
    private func resizeCell() {
        let indexPath = IndexPath(item: layout.currentPage, section: 0)
        if let cell = lastMoviesCollectionView.cellForItem(at: indexPath) {
            transformCell(cell)
        }
        pageControl.currentPage = indexPath.row
    }
    
    private func transformCell(_ cell: UICollectionViewCell, isEffect: Bool = true) {
        
        guard isEffect else {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            return
        }
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        for otherCell in lastMoviesCollectionView.visibleCells {
            guard let indexPath = lastMoviesCollectionView.indexPath(for: otherCell) else { return }
            if indexPath.item != layout.currentPage {
                UIView.animate(withDuration: 0.2) {
                    otherCell.transform = .identity
                }
            }
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
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let identifier = String(describing: MovieDetailsViewController.self)
        guard let viewController = storyboard.instantiateViewController(identifier: identifier) as? MovieDetailsViewController else { return }
        switch collectionView {
        case lastMoviesCollectionView:
            if indexPath.item == layout.currentPage {
                viewModelDetails.movieID = viewModel.nowPlayingMovies[indexPath.item].id
            } else {
                lastMoviesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                layout.currentPage = indexPath.item
                layout.previosOffset = layout.updateOffset(lastMoviesCollectionView)
                return
            }
        case additionalCollectionView:
            viewModelDetails.movieID = viewModel.topRatedMovies[indexPath.item].id
        default:
            return
        }
        viewController.viewModel = viewModelDetails
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
}

extension MainScreenVC: UICollectionViewDelegateFlowLayout {
    
    // MARK: Define size of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case lastMoviesCollectionView:
            return CGSize(width: GlobalConstants.itemW,
                          height: GlobalConstants.itemH)
        default:
            let cellw: Int = Int(GlobalConstants.screenWidth * 0.275)
            let cellh: Int = cellw / 2 * 3
            return CGSize(width: cellw,
                          height: cellh)
        }
    }
    
    // MARK: Spacing boaders for lastMoviesCollectionView from all sides
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == additionalCollectionView {
            let padding = (GlobalConstants.screenWidth - GlobalConstants.screenWidthMinusPadding)
            return UIEdgeInsets(top: 0,
                                left: padding,
                                bottom: 0,
                                right: padding)
        } else { return UIEdgeInsets()}
    }
    
}

