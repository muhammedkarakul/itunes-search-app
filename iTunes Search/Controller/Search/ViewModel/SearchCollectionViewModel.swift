//
//  SearchCollectionViewModel.swift
//  iTunes Search
//
//  Created by Mete Karakul on 10.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import Foundation

final class SearchResultCollectionViewModel {
    var terms: [Term] = []
    
    var numberOfSections: Int {
        1
    }
    
    var numberOfRows: Int {
        terms.count
    }
    
    func viewModelForCell(at index: Int) -> SearchCellViewModel {
        return SearchCellViewModel()
    }
}
