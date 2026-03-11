//
//  WeekDay.swift
//  ember
//
//  Day model for weekly calendar display
//

import Foundation

struct WeekDay: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let label: String
    let hasCheckIn: Bool
    let dayNumber: Int
    
    // Optional check-in data for detailed view
    var moodLevel: Int?
    var energyLevel: Int?
    var stressLevel: Int?
    var note: String?
    
    var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
    
    var isFuture: Bool {
        date > Date()
    }
    
    var isPast: Bool {
        date < Calendar.current.startOfDay(for: Date())
    }
    
    var moodStatus: MoodStatus {
        guard let mood = moodLevel else { return .noData }
        switch mood {
        case 4...5: return .high
        case 3: return .medium
        case 1...2: return .low
        default: return .noData
        }
    }
    
    enum MoodStatus {
        case high
        case medium
        case low
        case noData
        
        var colorName: String {
            switch self {
            case .high: return "secondary"
            case .medium: return "warning"
            case .low: return "error"
            case .noData: return "textTertiary"
            }
        }
    }
    
    static func == (lhs: WeekDay, rhs: WeekDay) -> Bool {
        lhs.id == rhs.id
    }
}
