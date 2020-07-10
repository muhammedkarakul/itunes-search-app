//
//  APIClient.swift
//  ListIt
//
//  Created by Mete Karakul on 19.06.2020.
//  Copyright © 2020 Muhammed KARAKUL. All rights reserved.
//

import Foundation
import Alamofire
import PromisedFuture

class APIClient {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder()) -> Future<T, AFError> {
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
    
    static func search(withTerm term: String) -> Future<Term, AFError> {
        return performRequest(route: APIRouter.search(term: term))
    }
}
