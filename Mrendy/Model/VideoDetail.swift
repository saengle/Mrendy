//
//  VideoDetail.swift
//  Mrendy
//
//  Created by 쌩 on 6/26/24.
//
import Foundation

// MARK: - VideoDetail
struct VideoDetail: Decodable {
  
    let backdropPath: String?
    let posterPath: String?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case overview
    }
}
