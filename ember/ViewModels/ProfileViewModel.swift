//
//  ProfileViewModel.swift
//  ember
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class ProfileViewModel: ObservableObject {

    @Published var assessment: Assessment? = nil

    private let persistence = PersistenceService.shared
    func load() {
        assessment = persistence.loadAssessment()
    }
    init() {
        load()
    }



    var burnoutStage: String  { assessment?.burnoutStage ?? "—" }
    var analysis: String      { assessment?.analysis ?? "" }
    var recommendation: String { assessment?.recommendation ?? "" }
}
