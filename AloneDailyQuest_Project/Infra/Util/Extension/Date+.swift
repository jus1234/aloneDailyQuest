//
//  Date+.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/23/24.
//

import Foundation

extension Date {
    
    func toString(day: Date, with format: String) -> String {
        return DateFormatter.formatter(with: format).string(from: day)
    }
    
    func yesterdayString(with format: String) -> String {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? self
        return DateFormatter.formatter(with: format).string(from: yesterday)
    }
}

extension DateFormatter {
    static let yyyyMMdd: String = "yyyyMMdd"
    
    static func formatter(with format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}
