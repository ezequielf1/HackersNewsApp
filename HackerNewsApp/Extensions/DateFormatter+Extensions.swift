//
//  DateFormatter+Extensions.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 19/11/2020.
//

import Foundation

enum DateFormat: String {
    case full = "yyyy-MM-dd'T'HH:mm:ss.mmm'Z'"
}

extension DateFormatter {
    func format(dateString: String, format: DateFormat) -> Date? {
        dateFormat = format.rawValue
        return date(from: dateString)
    }
}
