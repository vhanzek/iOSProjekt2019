//
//  DateUtils.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 09/07/2019.
//

import Foundation

class DateUtils {
    
    public static let DATE_FORMAT = "dd-MM-yyyy"
    
    private static let dateFormatter = DateFormatter()
    
    public static func getDate(value: String) -> Date? {
        dateFormatter.dateFormat = DATE_FORMAT
        return dateFormatter.date(from: value)
    }
    
    public static func getString(date: Date) -> String? {
        dateFormatter.dateFormat = DATE_FORMAT
        return dateFormatter.string(from: date)
    }
}
