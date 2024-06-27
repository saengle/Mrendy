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

    func callRequestTMDB<T: Decodable>(api: APIModel, type: T.Type = T.self, completion: @escaping((Result<T, AFError>) -> Void)) {
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, encoding: api.encoding, headers: api.header ).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let repositories):
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

