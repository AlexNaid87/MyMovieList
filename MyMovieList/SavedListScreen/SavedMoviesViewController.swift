//
//  SavedMovies.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 02.05.2022.
//

import Foundation
import UIKit

class SavedMoviesVC: UIViewController {
    
    @IBOutlet weak var savedMoviesTableView: UITableView!
    
    let viewModel = SavedMoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavBar()
        setBackgroundImage(selectedView: view)
        setTableView()
    }
    
        override func viewWillAppear(_ animated: Bool) {
            viewModel.loadSavedMovieList {
                savedMoviesTableView.reloadData()
            }
        }
}

// MARK: Tableview Options
extension SavedMoviesVC: UITableViewDataSource, UITableViewDelegate {
    private func setTableView() {
        savedMoviesTableView.registerCellWithNib(cellClass: SavedMoviesTableViewCell.self)
        savedMoviesTableView.dataSource = self
        savedMoviesTableView.delegate = self
        viewModel.loadSavedMovieList {
            savedMoviesTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.savedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SavedMoviesTableViewCell = savedMoviesTableView.dequeueReusableCell(for:indexPath)
        
        let item = viewModel.savedItems[indexPath.row]
        cell.setupSavedMoviesCell(item: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let position = indexPath.row
            let item = viewModel.savedItems[position]
            DataManager.shared.remove(item)
            viewModel.savedItems.remove(at: position)
            savedMoviesTableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }
        let movieViewModel = MovieDetailsViewModel()
        movieViewModel.movieID = viewModel.savedItems[indexPath.row].id
        vc.viewModel = movieViewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
}







