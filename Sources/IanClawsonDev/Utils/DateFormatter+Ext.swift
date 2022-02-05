//
//  File.swift
//  
//
//  Created by Ian Clawson on 2/5/22.
//

import Foundation

extension DateFormatter {
    static var long: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
}

extension Date.ParseStrategy {
    static var yolo: Date.ParseStrategy {
        return Date.ParseStrategy(
            format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits) \(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .oneBased)) \(minute: .twoDigits)",
            locale: Locale(identifier: "es"),
            timeZone: .current)
    }
}
