//
//  ApiManager.swift
//  Mrendy
//
//  Created by 쌩 on 6/10/24.
//

import UIKit

import Alamofire

class ApiManager {
    
    static let shared = ApiManager()
    
    private init() {}
    
    func callRequestTMDB(api: APIModel, completion: @escaping((Result<Trendy, AFError>) -> Void)) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, encoding: api.encoding, headers: api.header ).responseDecodable(of: Trendy.self) { response in
            switch response.result {
            case .success(let repositories):
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func callRequestTMDB2<T: Decodable>(api: APIModel, type: T.Type = T.self, completion: @escaping((Result<T, AFError>) -> Void)) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, encoding: api.encoding, headers: api.header ).responseDecodable(of: T.self) { response in
            print(response)
            switch response.result {
            case .success(let repositories):
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func callRequestCredit(api: APIModel, completion: @escaping((Result<MovieCredit, AFError>) -> Void)) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, encoding: api.encoding, headers: api.header).responseDecodable(of: MovieCredit.self) { response in
            switch response.result {
              
            case .success(let repositories):
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func callRequestDetail(id: String, completion: @escaping((Result<VideoDetail, AFError>) -> Void)) {
        let url = "https://api.themoviedb.org/3/movie/\(id)"
        
        let parameters = ["language" : "ko-KR"]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(SecureAPI.apiToken)"
        ]
        AF.request(url, method: .get, parameters: parameters, headers: headers ).responseDecodable(of: VideoDetail.self) { response in
            switch response.result {
            case .success(let repositories):
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

