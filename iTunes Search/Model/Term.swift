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
    let trackPrice: Float
    let trackName: String
    let releaseDate: Date
    
    enum CodingKeys: String, CodingKey {
        case artworkUrl100
        case trackPrice
        case trackName
        case releaseDate
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artworkUrl100 = try values.decode(URL.self, forKey: CodingKeys.artworkUrl100)
        trackPrice = try values.decode(Float.self, forKey: CodingKeys.trackPrice)
        trackName = try values.decode(String.self, forKey: CodingKeys.trackName)
        releaseDate = try values.decode(Date.self, forKey: CodingKeys.releaseDate)
    }
}
