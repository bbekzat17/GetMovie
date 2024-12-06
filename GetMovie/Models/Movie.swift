//
//  Movie.swift
//  GetMovie
//
//  Created by Bekzat Batyrkhanov on 21.10.2024.
//

struct Movie: Codable {
    let title: String
    let year: String
    let imdb_id: String
}

struct MovieResponse: Decodable {
    let movie_results: [Movie]
}
