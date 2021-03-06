//
//  Util.swift
//  WeatherForecast
//
//  Created by CinqTest on 29/09/18.
//  Copyright © 2018 CinqTest. All rights reserved.
//

import Foundation

struct DateUtil {
    
    static func stringToDate(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date
    }
    
    static func sameDate(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedSame && calendar.compare(date1, to: date2, toGranularity: .month) == .orderedSame && calendar.compare(date1, to: date2, toGranularity: .year) == .orderedSame
    }
    
    static func getDay(date: Date?) -> Int {
        guard let date = date else { return 0 }
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    static func getMonth(date: Date?) -> Int {
        guard let date = date else { return 0 }
        let calendar = Calendar.current
        return calendar.component(.month, from: date)
    }
    static func getYear(date: Date?) -> Int {
        guard let date = date else { return 0 }
        let calendar = Calendar.current
        return calendar.component(.year, from: date)
    }
}
