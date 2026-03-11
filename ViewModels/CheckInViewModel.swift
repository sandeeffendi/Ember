//
//  CheckInViewModel.swift
//  ember
//

import Foundation
import SwiftUI

@MainActor
final class CheckInViewModel: ObservableObject {

    // MARK: - Published State
    @Published var moodLevel: Double = 3
    @Published var energyLevel: Double = 3
    @Published var stressLevel: Double = 3
    @Published var isSubmitted: Bool = false

    // MARK: - Derived
    var currentPhase: CheckInPhase { CheckInPhase.current }

    // MARK: - Dependencies
    private let persistence = PersistenceService.shared

    // MARK: - Actions
    func submit() {
        let checkIn = DailyCheckIn(
            phase: currentPhase,
            moodLevel: Int(moodLevel),
            energyLevel: Int(energyLevel),
            stressLevel: Int(stressLevel)
        )
        persistence.appendCheckIn(checkIn)
        withAnimation(.spring(duration: 0.4)) {
            isSubmitted = true
        }
    }

    func reset() {
        moodLevel = 3
        energyLevel = 3
        stressLevel = 3
        isSubmitted = false
    }
}
