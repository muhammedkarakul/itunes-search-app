//
//  Term.swift
//  iTunes Search
//
//  Created by Muhammed Karakul on 10.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import Foundation

struct Term: Codable {
    let artworkUrl100: URL
    let collectionPrice: Float
    let collectionName: String
    let releaseDate: Date
    
    enum CodingKeys: String, CodingKey {
        case artworkUrl100
        case collectionPrice
        case collectionName
        case releaseDate
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artworkUrl100 = try values.decode(URL.self, forKey: CodingKeys.artworkUrl100)
        collectionPrice = try values.decode(Float.self, forKey: CodingKeys.collectionPrice)
        collectionName = try values.decode(String.self, forKey: CodingKeys.collectionName)
        releaseDate = try values.decode(Date.self, forKey: CodingKeys.releaseDate)
    }
}
