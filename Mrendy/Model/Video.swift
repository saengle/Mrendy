//
//  Video.swift
//  Mrendy
//
//  Created by 쌩 on 7/2/24.
//

import Foundation

struct Video: Decodable {
    let id: Int?
    let results: [Key]?
    enum CodingKeys: String, CodingKey {
        case id, results
    }
}

struct Key: Decodable {
    let key: String?
    enum CodingKeys: String, CodingKey {
        case key
    }
}
