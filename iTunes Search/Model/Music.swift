//
//  Music.swift
//  iTunes Search
//
//  Created by Mete Karakul on 11.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import Foundation

struct Music: Codable {
    let artistName: String
    let collectionName: String
    let artworkUrl100: URL
    let collectionPrice: Float
    let releaseDate: Date
    let country: String
    let primaryGenreName: String
    let trackCount: Int
    let copyright: String
}


extension Music: Searchable {
    var detail: [Section] {
        let dictionary: [String : String] = [
            "Artist Name" : artistName,
            "Price" : "\(collectionPrice)$",
            "Release Date" : releaseDate.formattedDateString,
            "Country" : country,
            "Genre" : primaryGenreName,
            "Track Count" : "\(trackCount)",
            "Copyright" : copyright
        ]
        return dictionary.map { Section(name: $0.key, data: $0.value) }
    }
}
