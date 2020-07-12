//
//  Searchable.swift
//  iTunes Search
//
//  Created by Mete Karakul on 11.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import Foundation

protocol Searchable: Codable {
    var artworkUrl100: URL { get }
    var collectionPrice: Float { get }
    var collectionName: String { get }
    var releaseDate: Date { get }
    var detail: [Section] { get }
}
