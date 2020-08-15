//
//  APIConfiguration.swift
//  ListIt
//
//  Created by Muhammed Karakul on 19.06.2020.
//  Copyright © 2020 Muhammed KARAKUL. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
