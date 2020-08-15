//
//  Book.swift
//  iTunes Search
//
//  Created by Mete Karakul on 12.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import Foundation

struct Book: Codable {
    let artworkUrl100: URL
    let trackName: String
    let price: Float
    let releaseDate: Date
    let artistName: String
    let description: String
    let fileSizeBytes: Int
    let averageUserRating: Float = 0.0
    let genres: [String]
}

extension Book {
    var fileSizeMegaBytes: String {
        "\( fileSizeBytes / 1000000 ) MB"
    }
}

extension Book: Searchable {
    var collectionPrice: Float {
        price
    }
    
    var collectionName: String {
        trackName
    }
    
    var detail: [Section] {
        let dictionary: [String : String] = [
            "Artist Name" : artistName,
            "Price" : "\(price)$",
            "Release Date" : releaseDate.formattedDateString,
            "User Rating" : "\(averageUserRating)",
            "Genre" : genres.joined(separator: ", "),
            "Size" : fileSizeMegaBytes,
            "Description" : description
        ]
        return dictionary.map { Section(name: $0.key, data: $0.value) }
    }
}
