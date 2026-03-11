//
//  CheckInViewModel.swift
//  ember
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class CheckInViewModel: ObservableObject {

    // MARK: - Published State
    @Published var moodLevel: Double = 3
    @Published var energyLevel: Double = 3
    @Published var stressLevel: Double = 3
    @Published var isSubmitted: Bool = false
    @Published var isPhaseAvailable: Bool = true
    
    // MARK: - Session State
    @Published private(set) var existingCheckIn: DailyCheckIn?
    @Published private(set) var canSubmit: Bool = true

    // MARK: - Dependencies
    private let persistence = PersistenceService.shared
    
    init() {
        loadSessionState()
    }
    
    // MARK: - Derived
    var currentPhase: CheckInPhase { CheckInPhase.current }
    
    var isUpdating: Bool {
        existingCheckIn != nil
    }
    
    var statusMessage: String {
        if !isPhaseAvailable {
            return "This check-in is not available yet. Come back during \(currentPhase.timeRange)."
        }
        if let existing = existingCheckIn {
            return "You've already checked in. You can update your response."
        }
        return "Take less than 10 seconds"
    }
    
    // MARK: - Actions
    func loadSessionState() {
        let phase = currentPhase
        isPhaseAvailable = phase.isAvailable
        
        if let existing = persistence.getCheckIn(for: phase, on: Date()) {
            existingCheckIn = existing
            canSubmit = true // Allow update
            // Pre-fill with existing values
            moodLevel = Double(existing.moodLevel)
            energyLevel = Double(existing.energyLevel)
            stressLevel = Double(existing.stressLevel)
            isSubmitted = true
        } else {
            existingCheckIn = nil
            canSubmit = isPhaseAvailable
            isSubmitted = false
        }
    }
    
    func submit() {
        guard canSubmit else { return }
        
        let checkIn = DailyCheckIn(
            phase: currentPhase,
            moodLevel: Int(moodLevel),
            energyLevel: Int(energyLevel),
            stressLevel: Int(stressLevel)
        )
        
        // Use upsert to insert or replace
        persistence.upsertCheckIn(checkIn)
        
        existingCheckIn = checkIn
        isSubmitted = true
        
        withAnimation(.spring(duration: 0.4)) {
            // Animation handled in view
        }
    }
    
    func reset() {
        moodLevel = 3
        energyLevel = 3
        stressLevel = 3
        isSubmitted = false
    }
    
    func refresh() {
        loadSessionState()
    }
}
