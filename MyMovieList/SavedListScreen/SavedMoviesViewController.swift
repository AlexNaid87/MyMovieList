//
//  SavedMovies.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 02.05.2022.
//

import Foundation
import UIKit

class SavedMoviesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var savedMoviesTableView: UITableView!
    
    let savedMoviesViewModel = SavedMoviesViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedMoviesTableView.register(UINib(nibName: "SavedMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "SavedMoviesTableViewCell")
        savedMoviesTableView.dataSource = self
        savedMoviesTableView.delegate = self
        savedMoviesViewModel.loadSavedMovieList {
            savedMoviesTableView.reloadData()
        }
    }
    
        override func viewWillAppear(_ animated: Bool) {
            savedMoviesViewModel.loadSavedMovieList {
                savedMoviesTableView.reloadData()
            }
        }
    
    
    //  MARK: TableView options:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMoviesViewModel.savedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedMoviesTableView.dequeueReusableCell(withIdentifier: "SavedMoviesTableViewCell", for: indexPath) as! SavedMoviesTableViewCell
        
        let item = savedMoviesViewModel.savedItems[indexPath.row]
        cell.setupSavedMoviesCell(item: item)
        
        return cell
    }
    
    //  MARK: Heigth of  row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // MARK: Height between cells in sections
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return cellSpacingHeight
//    }
    
    //  MARK: Delete item option
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let position = indexPath.row
            let item = savedMoviesViewModel.savedItems[position]
            DataManager.shared.remove(item)
            savedMoviesViewModel.savedItems.remove(at: position)
            savedMoviesTableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    //  MARK: Open a Detailed VC about Movie
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }

        MovieDetailsViewModel.shared.movieID = savedMoviesViewModel.savedItems[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
}









