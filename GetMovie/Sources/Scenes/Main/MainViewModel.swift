//
//  MainViewModel.swift
//  GetMovie
//
//  Created by Bekzat Batyrkhanov on 06.12.2024.
//

import Foundation

class MovieViewModel {
    private var movies: [Movie] = []
    var reloadTableView: (() -> Void)?

    var numberOfRows: Int {
        return movies.count
    }

    func getMovieTitle(at index: Int) -> String {
        print(movies)
        return movies[index].title
    }

    func fetchTrendingMovies() {
        NetworkService.shared.fetchTrendingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.reloadTableView?()
            case .failure(let error):
                print("Error fetching movies: \(error.localizedDescription)")
            }
        }
    }
}
