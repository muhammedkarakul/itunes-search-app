//
//  Software.swift
//  iTunes Search
//
//  Created by Mete Karakul on 12.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import Foundation

struct Software: Codable {
    let artworkUrl100: URL
    let trackName: String
    let price: Float
    let releaseDate: Date
    let artistName: String
    let version: String
    let description: String
    let primaryGenreName: String
    let fileSizeBytes: String
}

extension Software {
    var fileSizeMegaBytes: String {
        "\( (fileSizeBytes as NSString).intValue / 1000000 ) MB"
    }
}

extension Software: Searchable {
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
            "Version" : version,
            "Genre" : primaryGenreName,
            "Size" : fileSizeMegaBytes,
            "Description" : description
        ]
        return dictionary.map { Section(name: $0.key, data: $0.value) }
    }
}
