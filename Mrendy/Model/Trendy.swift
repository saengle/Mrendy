//
//  Trandy.swift
//  Mrendy
//
//  Created by 쌩 on 6/10/24.
//

import Foundation


import Foundation

// MARK: - Trandy
struct Trendy: Codable {
    let page: Int?
    let results: [Results]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Results: Codable {
    let backdropPath: String?
    let id: Int?
    let originalTitle, overview, posterPath: String?
    let mediaType: String?
    let adult: Bool?
    let title: String?
    let originalLanguage: String?
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let originalName, name, firstAirDate: String?
    let originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult, title
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originalName = "original_name"
        case name
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}

   
