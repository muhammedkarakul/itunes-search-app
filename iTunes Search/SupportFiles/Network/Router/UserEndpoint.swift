//
//  UserEndpoint.swift
//  ListIt
//
//  Created by Mete Karakul on 19.06.2020.
//  Copyright © 2020 Muhammed KARAKUL. All rights reserved.
//

import Foundation
import Alamofire

enum UserEndpoint: APIConfiguration {
    
    case search(term: String)
 
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .search(let term):
            return [NetworkConstants.APIParameterKey.term: term]
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
 
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
