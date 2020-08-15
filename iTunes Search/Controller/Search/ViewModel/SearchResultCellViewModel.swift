//
//  SearchResultCellViewModel.swift
//  iTunes Search
//
//  Created by Muhammed Karakul on 10.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import Foundation
import Kingfisher

final class SearchResultCellViewModel {
    let searchable: Searchable
    
    init(searchable: Searchable) {
        self.searchable = searchable
    }
    
    func configure(_ cell: SearchResultCell) {
        cell.artworkImageView.kf.setImage(with: searchable.artworkUrl100)
        cell.name = searchable.collectionName
        cell.price = searchable.collectionPrice
        cell.relaseDate = searchable.releaseDate
    }
}
