//
//  TMDBAPI.swift
//  Mrendy
//
//  Created by 쌩 on 6/26/24.
//

import Foundation
import Alamofire
enum Period: String{
    case week = "/week"
    case day = "/day"
}

enum APIModel {
    
    case trendingAll(period: Period, page: Int)
    case trendingTV(period: Period, page: Int)
    case trendingMovie(period: Period, page: Int)
    case search(query: String, page: Int)
    case images(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    var endpoint: URL {
        switch self {
        case .trendingAll(period: let period, page: let page):
            return URL(string: baseURL + "trending/all" + period.rawValue)!
        case .trendingTV(period: let period, page: let page):
            return URL(string: baseURL + "trending/tv" + period.rawValue)!
        case .trendingMovie(period: let period, page: let page):
            return URL(string: baseURL + "trending/movie" + period.rawValue)!
        case .search:
            return   URL(string: baseURL + "search/multi")!
        case .images(let id):
            return   URL(string: baseURL + "movie/\(id)/images")!
        }
    }
    
    var header: HTTPHeaders {
        return [
            "accept": "application/json",
            "Authorization": "Bearer \(SecureAPI.apiToken)"
        ]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: [String: String]{
        switch self {
        case    .trendingAll(period: let period, page: let page),
                .trendingTV(period: let period, page: let page),
                .trendingMovie(period: let period, page: let page):
            return  [ "language" : "ko-KR",
                      "page" : String(page)]
        case.search(query: let query, page: let page):
            return [ "query" : query ,
                     "language" : "ko-KR",
                     "page" : "\(page)"]
        case .images:
            return ["": ""]
        }
    }
    
    var encoding: URLEncoding {
        return URLEncoding(destination: .queryString)
    }
}
