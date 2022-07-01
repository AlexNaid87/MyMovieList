//
//  PeopleDetailsViewModel.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 18.05.2022.
//

import Foundation

class PeopleDetailsViewModel {
    
    static let shared = PeopleDetailsViewModel()
    private init() {}
    
    var peopleID: Int?
    var people: PeopleDetails?
    var cast: [Cast] = []
    
    func loadPeople(completionBlock: @escaping ((PeopleDetails)->())) {
        guard let peopleID = peopleID else { return }
        NetManager().getPeopleDetails(peopleID: peopleID) { people in
            self.people = people
            completionBlock(people)
        }
    }
    
    func loadMovieCredits(completion: @escaping (()->())) {
        guard let peopleID = peopleID else { return }
        NetManager().getMoviesCredits(peopleID: peopleID) { items in
            self.cast = items
            completion()
        }
    }
    
}
