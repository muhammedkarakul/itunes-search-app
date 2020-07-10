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
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
    }
    
    static func search(withTerm term: String, andMedia media: String, andLimit limit: Int) -> Future<SearchResult, AFError> {
        return performRequest(route: APIRouter.search(term: term, media: media, limit: limit))
    }
}
