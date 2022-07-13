//
//  NewManager.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 02.05.2022.
//

import Foundation
import Alamofire

class NetManager {
    
    func getMovieVideo(movieID: Int, completion: @escaping (([Video])->())) {
        let infoRequest = "movie/\(movieID)/videos"
        getRequest(infoRequest: infoRequest, word: "", model: VideoResponse.self) { data in
            completion(data.results ?? [])
        }
    }
    
    func getSearchedPeople(word: String, completion: @escaping (([People])->())) {
        let infoRequest = "search/person"
        getRequest(infoRequest: infoRequest, word: word, model: PeopleResponce.self) { data in
            completion(data.results ?? [])
        }
    }
    
    func getSearchedTVShows(word: String, completion: @escaping (([TVShow])->())) {
        let infoRequest = "search/tv"
        getRequest(infoRequest: infoRequest, word: word, model: TVShowResponce.self) { data in
            completion(data.results ?? [])
        }
    }
    
    func getSearchedMovies(word: String, completion: @escaping (([Movie])->())) {
        let infoRequest = "search/movie"
        getRequest(infoRequest: infoRequest, word: word, model: MoviesResponse.self) { data in
            completion(data.results ?? [])
        }
    }

    func getMovieDetails(movieID: Int, completion: @escaping ((MovieDetails)->())) {
        let infoRequest = "movie/\(movieID)"
        getRequest(infoRequest: infoRequest, model: MovieDetails.self) { data in
            completion(data)
        }
    }
    
    func getTVShowDetails(tvShowID: Int, completion: @escaping ((TVShowDetails)->())) {
        let infoRequest = "tv/\(tvShowID)"
        getRequest(infoRequest: infoRequest, model: TVShowDetails.self) { data in
            completion(data)
        }
    }
    
    func getPeopleDetails(peopleID: Int, completion: @escaping ((PeopleDetails)->())) {
        let infoRequest = "person/\(peopleID)"
        getRequest(infoRequest: infoRequest, model: PeopleDetails.self) { data in
            completion(data)
        }
    }
    
    func getMoviesCredits(peopleID: Int, completion: @escaping (([Cast])->())) {
        let infoRequest = "person/\(peopleID)/movie_credits"
        getRequest(infoRequest: infoRequest, model: CreditsRespons.self) { data in
            completion(data.cast ?? [])
        }
    }
    
    func getTopRatedMovies(completion: @escaping (([Movie])->())) {
        getRequest(infoRequest: "movie/top_rated",  model: TopRatedMoviesResponce.self) { data in
            completion(data.results ?? [])
        }
    }
    
    func getPeople(completion: @escaping (([People])->())) {
        getRequest(infoRequest: "person/popular", model: PeopleResponce.self) { data in
            completion(data.results ?? [])
        }
    }
    
    func getTVShows(completion: @escaping (([TVShow])->())) {
        getRequest(infoRequest: "tv/popular", model: TVShowResponce.self) { data in
            completion(data.results ?? [])
        }
    }
    
    func getNowPlayingMovies(completion: @escaping (([Movie])->())) {
        getRequest(infoRequest: "movie/now_playing",model: NowPlayingResponce.self) { data in
            completion(data.results ?? [])
        }
    }
    
    func getPopularMovies(completion: @escaping (([Movie])->())) {
        getRequest(infoRequest: "movie/popular", model: MoviesResponse.self) { data in
            completion(data.results ?? [])
        }
    }
    
    private func getRequest<T: Decodable>(infoRequest: String,
                                          word: String = "",
                                          model: T.Type,
                                          completion: @escaping (T) -> ()) {
        let domenUrl = GlobalConstants.imbdUrl
        let api = "api_key=\(GlobalConstants.api)"
        let searchWord = "&query=\(word)"
        let url = domenUrl + infoRequest + "?" + api + searchWord
        AF.request(url).response { response in
            guard let response = response.data else { return }
            do {
                let data = try JSONDecoder().decode(model, from: response)
                completion(data)
            } catch {
                print("JSON decode error:", error)
                return
            }
        }
    }

}
