//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Mete Karakul on 10.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import Foundation

struct Term: Codable {
    let artworkUrl100: URL
    let collectionPrice: Float
    let collectionName: String
    let relaseDate: Date
    
    enum CodingKeys: String, CodingKey {
        case artworkUrl100
        case collectionPrice
        case collectionName
        case relaseDate
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artworkUrl100 = try values.decode(URL.self, forKey: CodingKeys.artworkUrl100)
        collectionPrice = try values.decode(Float.self, forKey: CodingKeys.collectionPrice)
        collectionName = try values.decode(String.self, forKey: CodingKeys.collectionName)
        relaseDate = try values.decode(Date.self, forKey: CodingKeys.relaseDate)
    }
}
