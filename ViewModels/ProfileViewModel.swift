//
//  ProfileViewModel.swift
//  ember
//

import Foundation
import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {

    @Published var assessment: Assessment? = nil

    private let persistence = PersistenceService.shared

    init() {
        load()
    }

    func load() {
        assessment = persistence.loadAssessment()
    }

    var burnoutStage: String  { assessment?.burnoutStage ?? "—" }
    var analysis: String      { assessment?.analysis ?? "" }
    var recommendation: String { assessment?.recommendation ?? "" }
}
