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
    let term: Term
    
    init(term: Term) {
        self.term = term
    }
    
    func configure(_ cell: SearchResultCell) {
        cell.artworkImageView.kf.setImage(with: term.artworkUrl100)
        cell.collectionName = term.collectionName
        cell.collectionPrice = term.collectionPrice
        cell.relaseDate = term.releaseDate
    }
}
