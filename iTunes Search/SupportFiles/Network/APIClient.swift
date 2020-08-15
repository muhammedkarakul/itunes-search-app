//
//  APIClient.swift
//  ListIt
//
//  Created by Muhammed Karakul on 19.06.2020.
//  Copyright © 2020 Muhammed KARAKUL. All rights reserved.
//

import Foundation
import Alamofire
import PromisedFuture

class APIClient {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder.iTunesDecoder) -> Future<T, AFError> {
        return Future { completion in
            AF.request(route).responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
    }
    
    private static func search<T:Codable>(withTerm term: String, andMedia media: String, andEntity entity: String, andLimit limit: Int) -> Future<SearchResult<T>, AFError> {
        return performRequest(route: APIRouter.search(term: term, media: media, entity: entity, limit: limit))
    }
    
    static func searchMovie(withTerm term: String) -> Future<SearchResult<Movie>, AFError> {
        search(withTerm: term, andMedia: "movie", andEntity: "movie", andLimit: 20)
    }
    
    static func searchMusic(withTerm term: String) -> Future<SearchResult<Music>, AFError> {
        search(withTerm: term, andMedia: "music", andEntity: "album", andLimit: 20)
    }
    
    static func searchApp(withTerm term: String) -> Future<SearchResult<Software>, AFError> {
        search(withTerm: term, andMedia: "software", andEntity: "software", andLimit: 20)
    }
    
    static func searchBook(withTerm term: String) -> Future<SearchResult<Book>, AFError> {
        search(withTerm: term, andMedia: "ebook", andEntity: "ebook", andLimit: 20)
    }
}
