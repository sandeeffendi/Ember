//
//  DailyCheckIn.swift
//  ember
//

import Foundation

/// Phase of the day for a check-in, mapped by current hour.
enum CheckInPhase: String, Codable, CaseIterable {
    case morning  = "Morning"
    case midday   = "Midday"
    case shutdown = "Shutdown"

    /// Derive the current phase from the device clock.
    static var current: CheckInPhase {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<11:  return .morning
        case 11..<17: return .midday
        default:      return .shutdown
        }
    }

    var icon: String {
        switch self {
        case .morning:  return "sunrise.fill"
        case .midday:   return "sun.max.fill"
        case .shutdown: return "moon.stars.fill"
        }
    }

    var label: String { rawValue }
    
    var timeRange: String {
        switch self {
        case .morning: return "05:00 - 11:00"
        case .midday: return "11:00 - 17:00"
        case .shutdown: return "17:00 - 23:00"
        }
    }
    
    var isAvailable: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        switch self {
        case .morning: return hour >= 5 && hour < 11
        case .midday: return hour >= 11 && hour < 17
        case .shutdown: return hour >= 17 && hour < 23
        }
    }
    
    var nextPhase: CheckInPhase? {
        switch self {
        case .morning: return .midday
        case .midday: return .shutdown
        case .shutdown: return nil
        }
    }
}

/// A single daily check-in entry recording mental state for one phase.
struct DailyCheckIn: Codable, Identifiable {
    var id: UUID = UUID()
    var date: Date = Date()
    var phase: CheckInPhase
    var moodLevel: Int      // 1–5
    var energyLevel: Int    // 1–5
    var stressLevel: Int    // 1–5

    /// Normalized date (midnight) for calendar comparison.
    var calendarDate: Date {
        Calendar.current.startOfDay(for: date)
    }
    
    /// Session key for uniqueness (date + phase)
    var sessionKey: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return "\(formatter.string(from: calendarDate))_\(phase.rawValue)"
    }
}
