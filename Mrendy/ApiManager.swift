//
//  ApiManager.swift
//  Mrendy
//
//  Created by 쌩 on 6/10/24.
//

import UIKit

import Alamofire

class ApiManager {
    
    func callRequestTrendy() {
        let url = "https://api.themoviedb.org/3/trending/all/day"
        
        let parameters = [ "language" : "ko-KR" ]
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(SecureAPI.apiToken)"
          ]
        
        AF.request(url,parameters: parameters, headers: headers).responseString{ response in
        print(response)
        }
    }
}
