//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Mete Karakul on 10.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let resultCount: Int
    let results: [Term]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case results
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try values.decode(Int.self, forKey: CodingKeys.resultCount)
        results = try values.decode([Term].self, forKey: CodingKeys.results)
    }
    
    init() {
        resultCount = 0
        results = []
    }
}
