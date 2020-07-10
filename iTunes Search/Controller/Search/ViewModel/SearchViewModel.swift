//
//  SearchViewModel.swift
//  iTunes Search
//
//  Created by Muhammed Karakul on 10.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import Foundation

final class SearchViewModel {
    var searchType: SearchType = .movies
    var searchResult = SearchResult()
    
    var numberOfSections: Int {
        1
    }
    
    var numberOfItems: Int {
        searchResult.results.count
    }
    
    func viewModelForCell(at index: Int) -> SearchResultCellViewModel {
        return SearchResultCellViewModel(term: searchResult.results[index])
    }
    
    func search(withText text: String, andLimit limit: Int, completion: @escaping (Error?) -> Void) {
        APIClient.search(withTerm: text, andLimit: limit).execute(onSuccess: { searchResult in
            self.searchResult = searchResult
            completion(nil)
        }) { error in
            completion(error)
        }
    }
}
