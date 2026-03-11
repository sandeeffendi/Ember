//
//  AppViewModel.swift
//  ember
//

import Foundation
import SwiftUI

/// Root view model that controls whether the user sees the Assessment onboarding
/// or the main app (Home). Single source of truth for app-level navigation state.
@MainActor
final class AppViewModel: ObservableObject {

    // MARK: - Published State
    @Published var hasCompletedAssessment: Bool = false
    @Published var storedAssessment: Assessment? = nil

    // MARK: - Dependencies
    private let persistence = PersistenceService.shared

    init() {
        loadState()
    }

    // MARK: - Public Actions

    /// Called after the assessment result is received from the AI.
    /// Persists the result and transitions to the main app.
    func completeAssessment(with result: BurnoutResult) {
        let assessment = Assessment(from: result)
        persistence.saveAssessment(assessment)
        self.storedAssessment = assessment
        withAnimation(.spring(duration: 0.5)) {
            hasCompletedAssessment = true
        }
    }

    /// Allows re-taking the assessment (e.g., from Profile page).
    func resetAssessment() {
        withAnimation(.spring(duration: 0.4)) {
            hasCompletedAssessment = false
            storedAssessment = nil
        }
    }

    // MARK: - Private

    private func loadState() {
        storedAssessment = persistence.loadAssessment()
        hasCompletedAssessment = storedAssessment != nil
    }
}
