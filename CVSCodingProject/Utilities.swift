//
//  Utilities.swift
//  CVSCodingProject
//
//  Created by Marco Gloria on 17/03/25.
//

import Foundation

extension String {
    func stringToDate(_ source: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: source)
        dateFormatter.dateFormat = "MMM-dd-yyyy"
        return dateFormatter.string(from: date!)

    }
    
    func htmlToString(_ source: String) -> String {
        return source.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
