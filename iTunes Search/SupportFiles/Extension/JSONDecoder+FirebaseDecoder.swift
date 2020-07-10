//
//  DateFormatter+APIDateFormatter.swift
//  ListIt
//
//  Created by Mete Karakul on 19.06.2020.
//  Copyright © 2020 Muhammed KARAKUL. All rights reserved.
//

import Foundation

extension JSONDecoder {
    static var iTunesDecoder: JSONDecoder {
        enum DateError: String, Error {
            case invalidDate
        }

        let decoder = JSONDecoder()

        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            
            throw DateError.invalidDate
        })
        
        return decoder
    }
}
