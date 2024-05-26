//
//  String+Extension.swift
//  Millie
//
//  Created by DK on 5/23/24.
//

import Foundation

extension String {
    var parsingDate: String? {
        let isoDateFormatter = ISO8601DateFormatter()
        if let date = isoDateFormatter.date(from: self) {
            let displayDateFormatter = DateFormatter()
            displayDateFormatter.dateFormat = "MM월 dd일 HH시 mm분"
            let displayDateString = displayDateFormatter.string(from: date)
            return displayDateString
        } else {
            return nil
        }
    }
}
