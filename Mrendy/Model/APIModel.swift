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
    case searchAll(query: String, page: Int)
    case movieSimilar(id: Int, page: Int)
    case movieRecommend(id: Int, page: Int)
    case images(id: Int)
    case movieCredit(id: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    var endpoint: URL {
        switch self {
        case .trendingAll(period: let period, page: _):
            return URL(string: baseURL + "trending/all" + period.rawValue)!
        case .trendingTV(period: let period, page: _):
            return URL(string: baseURL + "trending/tv" + period.rawValue)!
        case .trendingMovie(period: let period, page: _):
            return URL(string: baseURL + "trending/movie" + period.rawValue)!
        case .searchAll:
            return   URL(string: baseURL + "search/multi")!
        case .images(let id):
            return   URL(string: baseURL + "movie/\(id)/images")!
        case .movieSimilar(id: let id, page: _):
            return URL(string: baseURL + "movie/\(id))/similar")!
        case .movieRecommend(id: let id, page: let page):
            return URL(string: baseURL + "movie/\(id))/recommendations")!
        case .movieCredit(id: let id):
            return URL(string: baseURL + "movie/\(id))/credits")!
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
        case    .trendingAll(period: _, page: let page),
                .trendingTV(period: _, page: let page),
                .trendingMovie(period: _, page: let page):
            return  [ "language" : "ko-KR",
                      "page" : String(page)]
        case.searchAll(query: let query, page: let page):
            return [ "query" : query ,
                     "language" : "ko-KR",
                     "page" : "\(page)"]
        case .images:
            return ["": ""]
        case    .movieSimilar(id: _, page: let page),
                .movieRecommend(id: _, page: let page):
            return  [ "language" : "ko-KR",
                      "page" : String(page)]
        case .movieCredit(id: _):
            return [ "language" : "ko-KR"]
        }
    }
    
    var encoding: URLEncoding {
        return URLEncoding(destination: .queryString)
    }
}
