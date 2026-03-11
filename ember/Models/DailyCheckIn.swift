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
}
