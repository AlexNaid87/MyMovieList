//
//  NewManager.swift
//  MyMovieList
//
//  Created by Oleksandr Naidientsev on 02.05.2022.
//



import Foundation
import Alamofire

class NetManager {
    
    static let shared = NetManager()
    private init() { }
    let decoder = JSONDecoder()
    // MARK: getSearchedTVShows
    
    func getMovieVideo(movieID: Int, completion: @escaping (([Video])->())) {
        
        let urlString = "\(GlobalConstants.imbdUrl)3/movie/\(movieID)/videos?api_key=\(GlobalConstants.api)"
        AF.request(urlString).response { response in
            guard let response = response.data else { return }
            do {
                let searchedMoviesResponce = try self.decoder.decode(VideoResponse.self, from: response)
                completion(searchedMoviesResponce.results ?? [])
            } catch {
                print(error)
            }
        }
    }
    
    
    func getSearchedPeople(word: String, completionBlock: @escaping (([People])->())) {
        let urlString = "\(GlobalConstants.imbdUrl)3/search/person?api_key=\(GlobalConstants.api)&language=en-US&query=\(word)"
        AF.request(urlString).response { response in
            guard let response = response.data else { return }
            do {
                let searchedMoviesResponce = try self.decoder.decode(PeopleResponce.self, from: response)
                completionBlock(searchedMoviesResponce.results ?? [])
            } catch {
                print(error)
            }
        }
    }
    
    
    // MARK: getSearchedTVShows
    func getSearchedTVShows(word: String, completionBlock: @escaping (([TVShow])->())) {
        let urlString = "\(GlobalConstants.imbdUrl)3/search/tv?api_key=\(GlobalConstants.api)&language=en-US&query=\(word)"
        AF.request(urlString).response { response in
            guard let response = response.data else { return }
            do {
                let searchedMoviesResponce = try self.decoder.decode(TVShowResponce.self, from: response)
                completionBlock(searchedMoviesResponce.results ?? [])
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: getSearchedMovies
    func getSearchedMovies(word: String, completionBlock: @escaping (([Movie])->())) {
        let urlString = "\(GlobalConstants.imbdUrl)3/search/movie?api_key=\(GlobalConstants.api)&language=en-US&query=\(word)"
        AF.request(urlString).response { response in
            guard let response = response.data else { return }
            do {
                let searchedMoviesResponce = try self.decoder.decode(MoviesResponse.self, from: response)
                completionBlock(searchedMoviesResponce.results ?? [])
            } catch {
                print(error)
            }
        }
    }
    
    
    // MARK: getPopularMovies
    func getPopularMovies(completionBlock: @escaping (([Movie])->())) {
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=dc7779f2a307a05dd46746f976ce9642&language=en-US&page=1"
        AF.request(urlString).response { response in
            guard let response = response.data else { return }
            do {
                
                let popularMoviesResponce = try self.decoder.decode(MoviesResponse.self, from: response)
                completionBlock(popularMoviesResponce.results ?? [])
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: getTVShows
    func getTVShows(completionBlock: @escaping (([TVShow])->())) {
        let urlString = "https://api.themoviedb.org/3/tv/popular?api_key=dc7779f2a307a05dd46746f976ce9642&language=en-US&page=1"
        AF.request(urlString).response { response in
            guard let response = response.data else { return }
            do {
                let tvShowResponce = try self.decoder.decode(TVShowResponce.self, from: response)
                completionBlock(tvShowResponce.results ?? [])
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: getPeople
    func getPeople(completionBlock: @escaping (([People])->())) {
        let urlString = "https://api.themoviedb.org/3/person/popular?api_key=dc7779f2a307a05dd46746f976ce9642&language=en-US&page=1"
        AF.request(urlString).response { response in
            guard let response = response.data else { return }
            do {
                let tvShowResponce = try self.decoder.decode(PeopleResponce.self, from: response)
                completionBlock(tvShowResponce.results ?? [])
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: getMovieDetails
    func getMovieDetails(movieID: Int, completionBlock: @escaping ((MovieDetails)->())) {
        
        let urlRequest: String = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=dc7779f2a307a05dd46746f976ce9642&language=en-US"
        AF.request(urlRequest).response { response in
            do {
                let allData = try self.decoder.decode(MovieDetails?.self, from: response.data!)
                guard let movieDetailsData = allData else { return }
                completionBlock(movieDetailsData)
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: getTVShowDetails
    func getTVShowDetails(tvShowID: Int, completionBlock: @escaping ((TVShowDetails)->())) {
        
        let urlRequest: String = "https://api.themoviedb.org/3/tv/\(tvShowID)?api_key=dc7779f2a307a05dd46746f976ce9642&language=en-US"
        AF.request(urlRequest).response { response in
            do {
                let allData = try self.decoder.decode(TVShowDetails?.self, from: response.data!)
                guard let tvShowDetailsData = allData else { return }
                completionBlock(tvShowDetailsData)
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: getPeopleDetails
    func getPeopleDetails(peopleID: Int, completionBlock: @escaping ((PeopleDetails)->())) {
        
        let urlRequest: String = "https://api.themoviedb.org/3/person/\(peopleID)?api_key=dc7779f2a307a05dd46746f976ce9642&language=en-US"
        AF.request(urlRequest).response { response in
            do {
                let allData = try self.decoder.decode(PeopleDetails?.self, from: response.data!)
                guard let peopleDetailsData = allData else { return }
                completionBlock(peopleDetailsData)
            } catch {
                print(error)
            }
        }
    }
    
    func getNowPlayingMovies(completion: @escaping (([Movie])->())) {
        let urlString = "\(GlobalConstants.imbdUrl)3/movie/now_playing?api_key=\(GlobalConstants.api)"
        AF.request(urlString).response { response in
            guard let response = response.data else { return }
            do {
                let nowPlayingMoviesData = try self.decoder.decode(NowPlayingResponce.self, from: response)
                completion(nowPlayingMoviesData.results ?? [])
            } catch {
                print(error)
            }
        }
    }
    
    func getTopRatedMovies(completion: @escaping (([Movie])->())) {
        let urlString = "\(GlobalConstants.imbdUrl)3/movie/top_rated?api_key=\(GlobalConstants.api)"
        AF.request(urlString).response { response in
            do {
                let topRatedMoviesData = try JSONDecoder().decode(TopRatedMoviesResponce.self, from: response.data!)
                guard let topRatedMovies = topRatedMoviesData.results else { return }
                completion(topRatedMovies)
            } catch {
                print(error)
            }
        }
    }
}



