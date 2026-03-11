//
//  HomeViewModel.swift
//  ember
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var userName: String = ""

    private let persistence = PersistenceService.shared

    init() {
        loadUser()
    }

    /// Time-sensitive greeting for the home screen.
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12:  return "Good Morning"
        case 12..<17: return "Good Afternoon"
        default:      return "Good Evening"
        }
    }

    private func loadUser() {
        userName = persistence.loadUser()?.name ?? ""
    }
}
