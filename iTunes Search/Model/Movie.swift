//
//  Movie.swift
//  iTunes Search
//
//  Created by Mete Karakul on 11.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let artistName: String
    let trackName: String
    let artworkUrl100: URL
    let trackPrice: Float
    let releaseDate: Date
    let country: String
    let primaryGenreName: String
    let contentAdvisoryRating: String
    let longDescription: String
}

extension Movie: Searchable {
    var collectionPrice: Float {
        trackPrice
    }
    
    var collectionName: String {
        trackName
    }
    
    var detail: [Section] {
        let dictionary: [String : String] = [
            "Artist Name" : artistName,
            "Price" : "\(trackPrice)$",
            "Release Date" : releaseDate.formattedDateString,
            "Country" : country,
            "Genre" : primaryGenreName,
            "Rating" : contentAdvisoryRating,
            "Description" : longDescription
        ]
        return dictionary.map { Section(name: $0.key, data: $0.value) }
    }
}
