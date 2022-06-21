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
    
    let savedMoviesViewModel = SavedMoviesViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavBar()
        setBackgroundImage(imageName: "BGFinal2.png", selectedView: view)
        setTableView()
    }
    
        override func viewWillAppear(_ animated: Bool) {
            savedMoviesViewModel.loadSavedMovieList {
                savedMoviesTableView.reloadData()
            }
        }
}

// MARK: Tableview Options
extension SavedMoviesVC: UITableViewDataSource, UITableViewDelegate {
    private func setTableView() {
        savedMoviesTableView.register(UINib(nibName: "SavedMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "SavedMoviesTableViewCell")
        savedMoviesTableView.dataSource = self
        savedMoviesTableView.delegate = self
        savedMoviesViewModel.loadSavedMovieList {
            savedMoviesTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMoviesViewModel.savedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = savedMoviesTableView.dequeueReusableCell(withIdentifier: "SavedMoviesTableViewCell", for: indexPath) as! SavedMoviesTableViewCell
        
        let item = savedMoviesViewModel.savedItems[indexPath.row]
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
            let item = savedMoviesViewModel.savedItems[position]
            DataManager.shared.remove(item)
            savedMoviesViewModel.savedItems.remove(at: position)
            savedMoviesTableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController else { return }

        MovieDetailsViewModel.shared.movieID = savedMoviesViewModel.savedItems[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}







