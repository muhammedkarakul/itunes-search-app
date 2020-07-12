//
//  APIRouter.swift
//  ListIt
//
//  Created by Muhammed Karakul on 19.06.2020.
//  Copyright © 2020 Muhammed KARAKUL. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case search(term: String, media: String, entity: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .search:
        return "/search"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .search(let term, let media, let entity):
            return [NetworkConstants.APIParameterKey.term : term, NetworkConstants.APIParameterKey.media : media, NetworkConstants.APIParameterKey.entity : entity]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkConstants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
 
        switch self.method.rawValue == "POST" {
        case true:
            if let parameters = parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
        case false:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
