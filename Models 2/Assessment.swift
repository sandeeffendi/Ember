//
//  Assessment.swift
//  ember
//

import Foundation

/// Persisted result of a completed burnout assessment.
/// Maps from BurnoutResult (AI response) into a storable model.
struct Assessment: Codable {
    var burnoutStage: String
    var analysis: String
    var recommendation: String
    var timestamp: Date

    init(from result: BurnoutResult) {
        self.burnoutStage = result.phaseLabel
        self.analysis = result.narrative
        self.recommendation = result.recommendations
        self.timestamp = Date()
    }
}
