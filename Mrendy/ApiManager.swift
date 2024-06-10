//
//  ApiManager.swift
//  Mrendy
//
//  Created by 쌩 on 6/10/24.
//

import UIKit

import Alamofire

class ApiManager {
    
    func callRequestTrendy(completion: @escaping((Result<Trendy, AFError>) -> Void)) {
        let url = "https://api.themoviedb.org/3/trending/all/day"
        
        let parameters = [ "language" : "ko-KR" ]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(SecureAPI.apiToken)"
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers ).responseDecodable(of: Trendy.self) { response in
            switch response.result {
            case .success(let repositories):
                print(repositories.results)
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}