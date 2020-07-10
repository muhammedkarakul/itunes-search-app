//
//  K.swift
//  ListIt
//
//  Created by Muhammed Karakul on 19.06.2020.
//  Copyright © 2020 Muhammed KARAKUL. All rights reserved.
//

import Foundation

import Foundation

struct NetworkConstants {
    struct ProductionServer {
        static let baseURL = "https://itunes.apple.com"
    }
    
    struct APIParameterKey {
        static let term = "term"
        static let limit = "limit"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
