//
//  SearchViewModel.swift
//  iTunes Search
//
//  Created by Muhammed Karakul on 10.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import Foundation
import Alamofire
import PromisedFuture

final class SearchViewModel {
    var searchType: SearchType = .movie {
        didSet {
            searchables = []
        }
    }
    
    var searchables = [Searchable]()
    
    var numberOfSections: Int {
        1
    }
    
    var numberOfItems: Int {
        searchables.count
    }
    
    func viewModelForCell(at index: Int) -> SearchResultCellViewModel {
        SearchResultCellViewModel(searchable: searchables[index])
    }
    
    func viewModelForDetail(at index: Int, andArtworkImage image: UIImage?) -> DetailViewModel {
        return DetailViewModel(sections: searchables[index].detail, artworkImage: image, title: searchables[index].collectionName)
    }
    
    func search(withTerm term: String, completion: @escaping (Error?) -> Void) {
        switch searchType {
        case .movie:
            APIClient.searchMovie(withTerm: term).execute(onSuccess: { searchResult in
                self.searchables = searchResult.results
                completion(nil)
            }) { error in
                completion(error)
            }
        case .music:
            APIClient.searchMusic(withTerm: term).execute(onSuccess: { searchResult in
                self.searchables = searchResult.results
                completion(nil)
            }) { error in
                completion(error)
            }
        case .software:
            APIClient.searchApp(withTerm: term).execute(onSuccess: { searchResult in
                self.searchables = searchResult.results
                completion(nil)
            }) { error in
                completion(error)
            }
        case .book:
            APIClient.searchBook(withTerm: term).execute(onSuccess: { searchResult in
                self.searchables = searchResult.results
                completion(nil)
            }) { error in
                completion(error)
            }
        }
    }
}
