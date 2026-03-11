//
//  PersistenceService.swift
//  ember
//

import Foundation

/// Lightweight persistence using UserDefaults + JSON encoding.
/// Designed to be easily replaced with CoreData or SwiftData in the future.
final class PersistenceService {

    static let shared = PersistenceService()
    private init() {}

    private let defaults = UserDefaults.standard
    private let encoder  = JSONEncoder()
    private let decoder  = JSONDecoder()

    // MARK: - Keys
    private enum Key {
        static let assessment = "ember.assessment"
        static let checkIns   = "ember.checkIns"
        static let user       = "ember.user"
    }

    // MARK: - Assessment
    func saveAssessment(_ assessment: Assessment) {
        guard let data = try? encoder.encode(assessment) else { return }
        defaults.set(data, forKey: Key.assessment)
    }

    func loadAssessment() -> Assessment? {
        guard let data = defaults.data(forKey: Key.assessment) else { return nil }
        return try? decoder.decode(Assessment.self, from: data)
    }

    // MARK: - Daily Check-Ins
    func saveCheckIns(_ checkIns: [DailyCheckIn]) {
        guard let data = try? encoder.encode(checkIns) else { return }
        defaults.set(data, forKey: Key.checkIns)
    }

    func loadCheckIns() -> [DailyCheckIn] {
        guard let data = defaults.data(forKey: Key.checkIns) else { return [] }
        return (try? decoder.decode([DailyCheckIn].self, from: data)) ?? []
    }

    func appendCheckIn(_ checkIn: DailyCheckIn) {
        var existing = loadCheckIns()
        existing.append(checkIn)
        saveCheckIns(existing)
    }
    
    /// Check if user has already checked in for a specific phase on a specific date
    func hasCheckIn(for phase: CheckInPhase, on date: Date) -> Bool {
        let checkIns = loadCheckIns()
        let calendar = Calendar.current
        let targetDate = calendar.startOfDay(for: date)
        
        return checkIns.contains { checkIn in
            let checkInDate = calendar.startOfDay(for: checkIn.date)
            return checkInDate == targetDate && checkIn.phase == phase
        }
    }
    
    /// Get existing check-in for a specific phase on a specific date
    func getCheckIn(for phase: CheckInPhase, on date: Date) -> DailyCheckIn? {
        let checkIns = loadCheckIns()
        let calendar = Calendar.current
        let targetDate = calendar.startOfDay(for: date)
        
        return checkIns.first { checkIn in
            let checkInDate = calendar.startOfDay(for: checkIn.date)
            return checkInDate == targetDate && checkIn.phase == phase
        }
    }
    
    /// Get all check-ins for today
    func getTodayCheckIns() -> [DailyCheckIn] {
        let checkIns = loadCheckIns()
        let today = Calendar.current.startOfDay(for: Date())
        
        return checkIns.filter { checkIn in
            Calendar.current.startOfDay(for: checkIn.date) == today
        }
    }
    
    /// Get check-in status for all phases today
    func getTodayPhaseStatus() -> [CheckInPhase: DailyCheckIn?] {
        var status: [CheckInPhase: DailyCheckIn?] = [:]
        
        for phase in CheckInPhase.allCases {
            status[phase] = getCheckIn(for: phase, on: Date())
        }
        
        return status
    }
    
    /// Upsert check-in (insert or replace if exists)
    func upsertCheckIn(_ checkIn: DailyCheckIn) {
        var existing = loadCheckIns()
        
        // Remove existing check-in with same session key
        existing.removeAll { $0.sessionKey == checkIn.sessionKey }
        
        // Add new/updated check-in
        existing.append(checkIn)
        
        saveCheckIns(existing)
    }

    // MARK: - User
    func saveUser(_ user: User) {
        guard let data = try? encoder.encode(user) else { return }
        defaults.set(data, forKey: Key.user)
    }

    func loadUser() -> User? {
        guard let data = defaults.data(forKey: Key.user) else { return nil }
        return try? decoder.decode(User.self, from: data)
    }
}
