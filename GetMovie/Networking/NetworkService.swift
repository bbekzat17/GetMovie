//
//  MovieService.swift
//  GetMovie
//
//  Created by Bekzat Batyrkhanov on 21.10.2024.
//

import Foundation
import Alamofire

final class NetworkService {
    static let shared = NetworkService()
    
    func getMoviesByID() {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": "8996529fddmsh1541e169fcfb44bp196a32jsn5b7a70f61bb7",
            "Type": "get-movie-details"
        ]

        let url = "https://movies-tv-shows-database.p.rapidapi.com/"
        let parameters: [String: String] = [
            "movieid": "tt1375666"
        ]

        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("Response JSON: \(value)")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    func fetchTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": "8996529fddmsh1541e169fcfb44bp196a32jsn5b7a70f61bb7",
            "Type": "get-trending-movies"
        ]
        
        let url = "https://movies-tv-shows-database.p.rapidapi.com/"
        
        let parameters: [String: String] = [
            "page": "1"
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: MovieResponse.self) { response in
                switch response.result {
                case .success(let movieResponse):
                    completion(.success(movieResponse.movie_results))
                case .failure(let error):
                    print("Error fetching movies: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
    
}
