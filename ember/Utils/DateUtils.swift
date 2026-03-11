//
//  DateUtils.swift
//  ember
//
//  Date utility functions for weekly calculations
//

import Foundation

enum DateUtils {
    
    static func startOfWeek(for date: Date = Date()) -> Date {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: date)
        let weekday = calendar.component(.weekday, from: today)
        let daysFromMonday = (weekday + 5) % 7
        return calendar.date(byAdding: .day, value: -daysFromMonday, to: today)!
    }
    
    static func endOfWeek(for date: Date = Date()) -> Date {
        let calendar = Calendar.current
        let monday = startOfWeek(for: date)
        return calendar.date(byAdding: .day, value: 6, to: monday)!
    }
    
    static func daysInWeek(for date: Date = Date()) -> [Date] {
        let calendar = Calendar.current
        let monday = startOfWeek(for: date)
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: monday) }
    }
    
    static func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }
    
    static func isCurrentWeek(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let now = Date()
        let weekStart = startOfWeek(for: now)
        let weekEnd = endOfWeek(for: now)
        let normalizedDate = calendar.startOfDay(for: date)
        return normalizedDate >= calendar.startOfDay(for: weekStart) && 
               normalizedDate <= calendar.startOfDay(for: weekEnd)
    }
    
    static func weekLabel(for date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let start = startOfWeek(for: date)
        let end = endOfWeek(for: date)
        return "\(formatter.string(from: start)) - \(formatter.string(from: end))"
    }
    
    static func shortDayLabel(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    static func dayNumber(for date: Date) -> Int {
        Calendar.current.component(.day, from: date)
    }
    
    static func startOfDay(for date: Date) -> Date {
        Calendar.current.startOfDay(for: date)
    }
}
