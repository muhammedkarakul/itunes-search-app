//
//  Date+FormattedDateString.swift
//  iTunes Search
//
//  Created by Mete Karakul on 12.07.2020.
//  Copyright © 2020 Muhammed Karakul. All rights reserved.
//

import Foundation

extension Date {
    var formattedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
